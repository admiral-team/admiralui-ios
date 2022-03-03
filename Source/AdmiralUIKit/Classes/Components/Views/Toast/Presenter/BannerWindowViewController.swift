//
//  BannerWindowViewController.swift
//  AdmiralSwiftUI
//
//  Created on 24.12.2021.
//

import UIKit

private final class PassthroughWindow: UIWindow {
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)
        return view == self ? nil : view
    }
    
}

private final class PassthroughView: UIView {
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)
        return view == self ? nil : view
    }
    
}

protocol BannerWindowViewControllerDelegate: AnyObject {
    func startUserInteraction(viewController: BannerWindowViewController)
    func endUserInteraction(viewController: BannerWindowViewController)
}

class BannerWindowViewController: UIViewController {
    
    // MARK: - Type alias
    
    typealias VoidClosure = (() -> Void)?
    
    // MARK: - Internal Properties
    
    let banner: UIView
    var window: UIWindow?
    let config: BannerNotification.Config
    
    private(set) var showed: Bool = false
    
    weak var delegate: BannerWindowViewControllerDelegate?
    
    // MARK: - Private Properties
    
    private var currentAnimator: UIViewPropertyAnimator?
    private var animationProgress: CGFloat = 0.0
    
    private lazy var panGestureRecognizer: UIPanGestureRecognizer = {
        return InstantPanGestureRecognizer()
    }()
    
    private var insets: UIEdgeInsets {
        switch config.insets {
        case .safeArea(let offset):
            return view.safeAreaInsets + offset
        case .absolute(let insets):
            return insets
        }
    }
    
    private var currentPositionY: CGFloat = -.infinity
    
    private lazy var topConstraint: NSLayoutConstraint = {
        return banner.topAnchor.constraint(equalTo: view.topAnchor)
    }()
    
    private lazy var bottomConstraint: NSLayoutConstraint = {
        return view.bottomAnchor.constraint(equalTo: banner.bottomAnchor)
    }()
    
    private let queue: OperationQueue
    
    // MARK: - Initializers
    
    init(banner: UIView, config: BannerNotification.Config) {
        self.banner = banner
        self.config = config
        window = PassthroughWindow()
        
        queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1
        
        super.init(nibName: nil, bundle: nil)
        
        window?.backgroundColor = .clear
        window?.rootViewController = self
        setNeedsStatusBarAppearanceUpdate()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = PassthroughView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        moveUpBanner()

        showBanner()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIApplication.shared.windows.first?.rootViewController?.preferredStatusBarStyle ?? .default
    }
    
    // MARK: - Internal Methods
    
    func showBanner() {
        setBanner(showed: true)
    }
    
    func hideBanner() {
        setBanner(showed: false)
    }
    
    // MARK: - Private Methods
    
    private func commonInit() {
        addSubviews()
        setConstraints()
        setRecognizer()
    }
    
    private func setRecognizer() {
        panGestureRecognizer.addTarget(self, action: #selector(viewPanned(recognizer:)))
        banner.addGestureRecognizer(panGestureRecognizer)
    }
    
    private func addSubviews() {
        [banner].addToSuperview(view)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            topConstraint,
            bottomConstraint,
            banner.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutGrid.doubleModule),
            view.trailingAnchor.constraint(equalTo: banner.trailingAnchor, constant: LayoutGrid.doubleModule)
        ])
        
        switch config.direction {
        case .up:
            topConstraint.isActive = true
            bottomConstraint.isActive = false
        case .down:
            topConstraint.isActive = false
            bottomConstraint.isActive = true
        }
    }
    
    private func setBanner(showed: Bool) {
        queue.addOperation {
            let semaphore = DispatchSemaphore(value: 0)
            
            OperationQueue.main.addOperation { [weak self] in
                guard let `self` = self, self.currentAnimator == nil  else {
                    semaphore.signal()
                    return
                }
                
                self.animateTransition(showed: showed) {
                    semaphore.signal()
                }
            }
            
            semaphore.wait()
        }
    }

    private func animateTransitionIfNeeded(showed: Bool, completion: VoidClosure = nil) {
        guard currentAnimator == nil else { return }
        animateTransition(showed: showed, completion: completion)
    }
    
    private func animateTransition(showed: Bool, completion: VoidClosure = nil) {
        let duration = showed ? config.dismissingDuration : config.presentingDuration
        
        let animator = UIViewPropertyAnimator(duration: duration, curve: .easeInOut) {
            if showed {
                self.moveDownBanner()
            } else {
                self.moveUpBanner()
            }
        }
        
        animator.addCompletion { position in
            switch position {
            case .start:
                self.showed = !showed
            case .end:
                self.showed = showed
            case .current:
                break
            @unknown default:
                break
            }
            
            if showed {
                self.moveDownBanner()
            } else {
                self.moveUpBanner()
                self.removeWindow()
            }
            
            self.currentAnimator = nil
            
            completion?()
        }
        
        currentAnimator = animator
        currentAnimator?.startAnimation()
    }
    
    @objc private func viewPanned(recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            queue.cancelAllOperations()
            
            animateTransitionIfNeeded(showed: !showed)
            currentAnimator?.pauseAnimation()
            
            if let animator = currentAnimator {
                animationProgress = animator.fractionComplete
            }
            
            delegate?.startUserInteraction(viewController: self)
            
        case .changed:
            if let animator = currentAnimator {
                let translation = recognizer.translation(in: banner)
                var fraction = -translation.y / banner.frame.height
                
                if showed { fraction *= 1 }
                if animator.isReversed { fraction *= -1 }
                
                animator.fractionComplete = animationProgress + fraction
            }
            
        case .ended:
            if let animator = currentAnimator {
                animator.isReversed = !showed
                animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
            }
            
            delegate?.endUserInteraction(viewController: self)
        case .cancelled:
            delegate?.endUserInteraction(viewController: self)
            
        default:
            break
        }
    }
    
    private func moveUpBanner() {
        switch config.direction {
        case .up:
            currentPositionY = -banner.frame.height
            topConstraint.constant = currentPositionY
        case .down:
            currentPositionY = -banner.frame.height
            bottomConstraint.constant = currentPositionY
        }
        view.setNeedsLayout()
        view.layoutIfNeeded()
    }
    
    private func moveDownBanner() {
        switch config.direction {
        case .up:
            currentPositionY = insets.top
            topConstraint.constant = currentPositionY
        case .down:
            currentPositionY = banner.frame.height + insets.bottom
            bottomConstraint.constant = currentPositionY
        }
        view.setNeedsLayout()
        view.layoutIfNeeded()
    }
    
    private func removeWindow() {
        window?.isHidden = true
        window = nil
    }
    
}

class InstantPanGestureRecognizer: UIPanGestureRecognizer {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        if state == .began { return }
        super.touchesBegan(touches, with: event)
        state = .began
    }
    
}

