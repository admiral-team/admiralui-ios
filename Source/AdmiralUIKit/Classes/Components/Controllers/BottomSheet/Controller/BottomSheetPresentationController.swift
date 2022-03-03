//
//  BottomSheetPresentationController.swift
//  AdmiralUI
//
//  Created on 19.01.2021.
//

import UIKit
import AdmiralTheme

public enum BottomSheetPresentationState {
    case shortForm
    case longForm
}

/// The PanModalPresentationController is the middle layer between the presentingViewController
class BottomSheetPresentationController: UIPresentationController, AnyAppThemable {
    
    struct Constants {
        static let indicatorYOffset = CGFloat(8.0)
        static let snapMovementSensitivity = CGFloat(0.7)
        static let dragIndicatorSize = CGSize(width: 36.0, height: 5.0)
    }
    
    var scheme = BottomSheetPresentationControllerCustomTheme() {
        didSet { updateScheme() }
    }
    
    // MARK: - Private Properties
    
    private var isPresentedViewAnimating = false
    private var extendsPanScrolling = true
    
    /// A flag to determine if scrolling should be limited to the longFormHeight.
    /// Return false to cap scrolling at .max height.
    private var anchorModalToLongForm = true
    private var scrollViewYOffset: CGFloat = 0.0
    private var scrollObserver: NSKeyValueObservation?
    private var shortFormYPosition: CGFloat = 0
    private var longFormYPosition: CGFloat = 0
    
    /// Determine anchored Y postion based on the `anchorModalToLongForm` flag
    private var anchoredYPosition: CGFloat {
        let defaultTopOffset = presentable?.topOffset ?? 0
        return anchorModalToLongForm ? longFormYPosition : defaultTopOffset
    }
    
    private var presentable: BottomSheetPresentable? {
        return presentedViewController as? BottomSheetPresentable
    }
    
    private lazy var backgroundView: DimmedView = {
        let view: DimmedView
        view = DimmedView()
        view.didTap = { [weak self] _ in
            if self?.presentable?.allowsTapToDismiss == true {
                self?.presentedViewController.dismiss(animated: true)
            }
        }
        return view
    }()
    
    private lazy var panContainerView: BottomSheetContainerView = {
        let frame = containerView?.frame ?? .zero
        return BottomSheetContainerView(presentedView: presentedViewController.view, frame: frame)
    }()
    
    public override var presentedView: UIView {
        return panContainerView
    }
    
    private lazy var panGestureRecognizer: UIPanGestureRecognizer = {
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(didPanOnPresentedView(_ :)))
        gesture.minimumNumberOfTouches = 1
        gesture.maximumNumberOfTouches = 1
        gesture.delegate = self
        return gesture
    }()
    
    // MARK: - Deinitializers
    
    deinit {
        scrollObserver?.invalidate()
    }
    
    // MARK: - Lifecycle
    
    override public func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        configureViewLayout()
    }
    
    override public func presentationTransitionWillBegin() {
        guard let containerView = containerView else { return }
        
        layoutBackgroundView(in: containerView)
        layoutPresentedView(in: containerView)
        configureScrollViewInsets()
        
        guard let coordinator = presentedViewController.transitionCoordinator else {
            backgroundView.dimState = .max
            return
        }
        
        coordinator.animate(alongsideTransition: { [weak self] _ in
            self?.backgroundView.dimState = .max
            self?.presentedViewController.setNeedsStatusBarAppearanceUpdate()
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now(), execute: { [weak self] in
            self?.adjustPresentedViewFrame()
        })
    }
    
    override public func presentationTransitionDidEnd(_ completed: Bool) {
        if completed { return }
        
        backgroundView.removeFromSuperview()
    }
    
    override public func dismissalTransitionWillBegin() {
        presentable?.panModalWillDismiss()
        
        guard let coordinator = presentedViewController.transitionCoordinator else {
            backgroundView.dimState = .off
            return
        }
        
        /// Drag indicator is drawn outside of view bounds
        /// so hiding it on view dismiss means avoiding visual bugs
        coordinator.animate(alongsideTransition: { [weak self] _ in
            self?.backgroundView.dimState = .off
            self?.presentingViewController.setNeedsStatusBarAppearanceUpdate()
        })
    }
    
    override public func dismissalTransitionDidEnd(_ completed: Bool) {
        if !completed { return }
        
        presentable?.panModalDidDismiss()
    }
    
    /// Update presented view size in response to size class changes
    override public func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        coordinator.animate(alongsideTransition: { [weak self] _ in
            guard
                let self = self,
                self.presentable != nil
            else { return }
            
            self.adjustPresentedViewFrame()
            self.addRoundedCorners(to: self.presentedView)
        })
    }
    
    // MARK: - AppThemable
    
    func apply(theme: AppTheme) {
        scheme = BottomSheetPresentationControllerCustomTheme(theme: theme)
    }
    
    private func updateScheme() {
        panContainerView.backgroundColor = scheme.backgroundColor.uiColor
    }
    
}

// MARK: - Public Methods

extension BottomSheetPresentationController {
    
    /// Transition the PanModalPresentationController
    /// to the given presentation state
    func transition(to state: BottomSheetPresentationState) {
        guard presentable?.shouldTransition(to: state) == true else { return }
        
        presentable?.willTransition(to: state)
        
        switch state {
        case .shortForm:
            snap(toYPosition: shortFormYPosition)
        case .longForm:
            snap(toYPosition: longFormYPosition)
        }
    }
    
    /// Operations on the scroll view, such as content height changes,
    /// or when inserting/deleting rows can cause the pan modal to jump,
    /// caused by the pan modal responding to content offset changes.
     
    /// To avoid this, you can call this method to perform scroll view updates,
    /// with scroll observation temporarily disabled.
    func performUpdates(_ updates: () -> Void) {
        guard let scrollView = presentable?.panScrollable else { return }
        
        /// Pause scroll observer
        scrollObserver?.invalidate()
        scrollObserver = nil
        
        /// Perform updates
        updates()
        
        /// Resume scroll observer
        trackScrolling(scrollView)
        observe(scrollView: scrollView)
    }
    
    /// Updates the PanModalPresentationController layout
    /// based on values in the PanModalPresentable
     
    /// - Note: This should be called whenever any pan modal presentable value changes after the initial presentation
    func setNeedsLayoutUpdate() {
        configureViewLayout()
        adjustPresentedViewFrame()
        observe(scrollView: presentable?.panScrollable)
        configureScrollViewInsets()
    }
    
}

// MARK: - Presented View Layout Configuration

private extension BottomSheetPresentationController {

    /// Boolean flag to determine if the presented view is anchored
    var isPresentedViewAnchored: Bool {
        if
            !isPresentedViewAnimating,
            extendsPanScrolling,
            presentedView.frame.minY.rounded() <= anchoredYPosition.rounded() {
            return true
        }
        
        return false
    }
    
    private func layoutPresentedView(in containerView: UIView) {
        guard presentable != nil else { return }
        
        containerView.addSubview(presentedView)
        containerView.addGestureRecognizer(panGestureRecognizer)
        
        addRoundedCorners(to: presentedView)
        
        setNeedsLayoutUpdate()
    }
    
    /// Reduce height of presentedView so that it sits at the bottom of the screen
    private func adjustPresentedViewFrame() {
        guard let frame = containerView?.frame else { return }
        
        let adjustedSize = CGSize(
            width: frame.size.width,
            height: frame.size.height - anchoredYPosition)
        let panFrame = panContainerView.frame
        panContainerView.frame.size = frame.size
        
        if ![shortFormYPosition, longFormYPosition].contains(panFrame.origin.y) {
            let yPosition = panFrame.origin.y - panFrame.height + frame.height
            presentedView.frame.origin.y = max(yPosition, anchoredYPosition)
        }
        panContainerView.frame.origin.x = frame.origin.x
        presentedViewController.view.frame = CGRect(origin: .zero, size: adjustedSize)
    }
    
    private func layoutBackgroundView(in containerView: UIView) {
        containerView.addSubview(backgroundView)
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        backgroundView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        backgroundView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        backgroundView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
    }
    
    /// Calculates & stores the layout anchor points & options
    private func configureViewLayout() {
        apply(theme: defaultTheme)
        guard let layoutPresentable = presentedViewController as? BottomSheetPresentable.LayoutType
        else { return }
        
        shortFormYPosition = layoutPresentable.shortFormYPos
        longFormYPosition = layoutPresentable.longFormYPos
        anchorModalToLongForm = layoutPresentable.anchorModalToLongForm
        extendsPanScrolling = layoutPresentable.allowsExtendedPanScrolling
        
        containerView?.isUserInteractionEnabled = layoutPresentable.isUserInteractionEnabled
    }
    
    private func configureScrollViewInsets() {
        guard
            let scrollView = presentable?.panScrollable,
            !scrollView.isScrolling
        else { return }
        
        scrollView.showsVerticalScrollIndicator = false
        scrollView.scrollIndicatorInsets = presentable?.scrollIndicatorInsets ?? .zero
        
        scrollView.contentInsetAdjustmentBehavior = .never
    }
    
}

// MARK: - Pan Gesture Event Handler

private extension BottomSheetPresentationController {
    
    @objc func didPanOnPresentedView(_ recognizer: UIPanGestureRecognizer) {
        guard
            shouldRespond(to: recognizer),
            let containerView = containerView
        else {
            recognizer.setTranslation(.zero, in: recognizer.view)
            return
        }
        
        switch recognizer.state {
        case .began, .changed:
            respond(to: recognizer)
            
            if presentedView.frame.origin.y == anchoredYPosition && extendsPanScrolling {
                presentable?.willTransition(to: BottomSheetPresentationState.longForm)
            }
        default:
            let velocity = recognizer.velocity(in: presentedView)
            
            if isVelocityWithinSensitivityRange(velocity.y) {
                if velocity.y < 0 {
                    transition(to: BottomSheetPresentationState.longForm)
                } else if (nearest(
                            to: presentedView.frame.minY,
                            inValues: [longFormYPosition, containerView.bounds.height]) == longFormYPosition
                            && presentedView.frame.minY < shortFormYPosition)
                            || presentable?.allowsDragToDismiss == false {
                    transition(to: BottomSheetPresentationState.shortForm)
                } else {
                    presentedViewController.dismiss(animated: true)
                }
            } else {
                let position = nearest(
                    to: presentedView.frame.minY,
                    inValues: [containerView.bounds.height, shortFormYPosition, longFormYPosition])
                if position == longFormYPosition {
                    transition(to: BottomSheetPresentationState.longForm)
                } else if position == shortFormYPosition || presentable?.allowsDragToDismiss == false {
                    transition(to: BottomSheetPresentationState.shortForm)
                } else {
                    presentedViewController.dismiss(animated: true)
                }
            }
        }
    }
    
    func shouldRespond(to panGestureRecognizer: UIPanGestureRecognizer) -> Bool {
        guard
            presentable?.shouldRespond(to: panGestureRecognizer) == true ||
                !(panGestureRecognizer.state == .began || panGestureRecognizer.state == .cancelled)
        else {
            panGestureRecognizer.isEnabled = false
            panGestureRecognizer.isEnabled = true
            return false
        }
        return !shouldFail(panGestureRecognizer: panGestureRecognizer)
    }
    
    /// Communicate intentions to presentable and adjust subviews in containerView
    func respond(to panGestureRecognizer: UIPanGestureRecognizer) {
        presentable?.willRespond(to: panGestureRecognizer)
        
        var yDisplacement = panGestureRecognizer.translation(in: presentedView).y
        
        if presentedView.frame.origin.y < longFormYPosition {
            yDisplacement /= 2.0
        }
        adjust(toYPosition: presentedView.frame.origin.y + yDisplacement)
        
        panGestureRecognizer.setTranslation(.zero, in: presentedView)
    }
    
    func shouldFail(panGestureRecognizer: UIPanGestureRecognizer) -> Bool {
        guard !shouldPrioritize(panGestureRecognizer: panGestureRecognizer) else {
            presentable?.panScrollable?.panGestureRecognizer.isEnabled = false
            presentable?.panScrollable?.panGestureRecognizer.isEnabled = true
            return false
        }
        
        guard
            isPresentedViewAnchored,
            let scrollView = presentable?.panScrollable,
            scrollView.contentOffset.y > 0
        else {
            return false
        }
        
        let loc = panGestureRecognizer.location(in: presentedView)
        return (scrollView.frame.contains(loc) || scrollView.isScrolling)
    }
    
    func shouldPrioritize(panGestureRecognizer: UIPanGestureRecognizer) -> Bool {
        return panGestureRecognizer.state == .began &&
            presentable?.shouldPrioritize(panModalGestureRecognizer: panGestureRecognizer) == true
    }
    
    private func isVelocityWithinSensitivityRange(_ velocity: CGFloat) -> Bool {
        return (abs(velocity) - (1000 * (1 - Constants.snapMovementSensitivity))) > 0
    }
    
    // swiftlint:disable multiple_closures_with_trailing_closure
    func snap(toYPosition yPos: CGFloat) {
        BottomSheetModalAnimator.animate({ [weak self] in
            self?.adjust(toYPosition: yPos)
            self?.isPresentedViewAnimating = true
        }, config: presentable) { [weak self] didComplete in
            self?.isPresentedViewAnimating = !didComplete
        }
    }
    
    /// Sets the y position of the presentedView & adjusts the backgroundView.
    func adjust(toYPosition yPos: CGFloat) {
        presentedView.frame.origin.y = max(yPos, anchoredYPosition)
        
        guard presentedView.frame.origin.y > shortFormYPosition else {
            backgroundView.dimState = .max
            return
        }
        
        let yDisplacementFromShortForm = presentedView.frame.origin.y - shortFormYPosition
        
        backgroundView.dimState = .percent(1.0 - (yDisplacementFromShortForm / presentedView.frame.height))
    }
    
    func nearest(to number: CGFloat, inValues values: [CGFloat]) -> CGFloat {
        guard let nearestVal = values.min(by: { abs(number - $0) < abs(number - $1) })
        else { return number }
        return nearestVal
    }
    
}

// MARK: - UIScrollView Observer

private extension BottomSheetPresentationController {
    
    private func observe(scrollView: UIScrollView?) {
        scrollObserver?.invalidate()
        scrollObserver = scrollView?.observe(\.contentOffset, options: .old) { [weak self] scrollView, change in
            
            guard self?.containerView != nil
            else { return }
            
            self?.didPanOnScrollView(scrollView, change: change)
        }
    }
    
    private func didPanOnScrollView(_ scrollView: UIScrollView, change: NSKeyValueObservedChange<CGPoint>) {
        guard
            !presentedViewController.isBeingDismissed,
            !presentedViewController.isBeingPresented
        else { return }
        
        if !isPresentedViewAnchored && scrollView.contentOffset.y > 0 {
            haltScrolling(scrollView)
            
        } else if scrollView.isScrolling || isPresentedViewAnimating {
            if isPresentedViewAnchored {
                trackScrolling(scrollView)
            } else {
                haltScrolling(scrollView)
            }
        } else if presentedViewController.view.isKind(of: UIScrollView.self)
                    && !isPresentedViewAnimating && scrollView.contentOffset.y <= 0 {
            handleScrollViewTopBounce(scrollView: scrollView, change: change)
        } else {
            trackScrolling(scrollView)
        }
    }
    
    ///  Halts the scroll of a given scroll view & anchors it at the `scrollViewYOffset`
    private func haltScrolling(_ scrollView: UIScrollView) {
        scrollView.setContentOffset(CGPoint(x: 0, y: scrollViewYOffset), animated: false)
        scrollView.showsVerticalScrollIndicator = false
    }
    
    ///  As the user scrolls, track & save the scroll view y offset.
    ///  This helps halt scrolling when we want to hold the scroll view in place.
    private func trackScrolling(_ scrollView: UIScrollView) {
        scrollViewYOffset = max(scrollView.contentOffset.y, 0)
        scrollView.showsVerticalScrollIndicator = true
    }
    
    /// To ensure that the scroll transition between the scrollView & the modal
    /// is completely seamless, we need to handle the case where content offset is negative.
     
    /// In this case, we follow the curve of the decelerating scroll view.
    /// This gives the effect that the modal view and the scroll view are one view entirely.
     
    /// - Note: This works best where the view behind view controller is a UIScrollView.
    private func handleScrollViewTopBounce(scrollView: UIScrollView, change: NSKeyValueObservedChange<CGPoint>) {
        guard
            let oldYValue = change.oldValue?.y,
            scrollView.isDecelerating
        else { return }
        
        let yOffset = scrollView.contentOffset.y
        let presentedSize = containerView?.frame.size ?? .zero
        
        /// Decrease the view bounds by the y offset so the scroll view stays in place
        /// and we can still get updates on its content offset
        presentedView.bounds.size = CGSize(
            width: presentedSize.width,
            height: presentedSize.height + yOffset)
        
        if oldYValue > yOffset {
            /// Move the view in the opposite direction to the decreasing bounds
            /// until half way through the deceleration so that it appears
            /// as if we're transferring the scrollView drag momentum to the entire view
            presentedView.frame.origin.y = longFormYPosition - yOffset
        } else {
            scrollViewYOffset = 0
            snap(toYPosition: longFormYPosition)
        }
        
        scrollView.showsVerticalScrollIndicator = false
    }
    
}

// MARK: - UIGestureRecognizerDelegate

extension BottomSheetPresentationController: UIGestureRecognizerDelegate {
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return otherGestureRecognizer.view == presentable?.panScrollable
    }
    
}

// MARK: - UIBezierPath

private extension BottomSheetPresentationController {
    
    private func addRoundedCorners(to view: UIView) {
        let radius = presentable?.cornerRadius ?? 0
        let path = UIBezierPath(
            roundedRect: view.bounds,
            byRoundingCorners: [.topLeft, .topRight],
            cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        view.layer.mask = mask
        
        view.layer.shouldRasterize = true
        view.layer.rasterizationScale = UIScreen.main.scale
    }
    
}

// MARK: - Helper Extensions

private extension UIScrollView {
    
    var isScrolling: Bool {
        return isDragging && !isDecelerating || isTracking
    }
    
}
