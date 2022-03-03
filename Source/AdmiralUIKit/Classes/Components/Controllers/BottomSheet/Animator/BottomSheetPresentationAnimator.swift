//
//  BottomSheetPresentationAnimator.swift
//  AdmiralUI
//
//  Created on 19.01.2021.
//

import UIKit

/// Handles the animation of the presentedViewController as it is presented or dismissed.
class BottomSheetPresentationAnimator: NSObject {

    enum TransitionStyle {
        case presentation
        case dismissal
    }

    // MARK: - Private Properties

    private let transitionStyle: TransitionStyle

    // MARK: - Initializers

    required init(transitionStyle: TransitionStyle) {
        self.transitionStyle = transitionStyle
        super.init()
    }

    // MARK: - Private Properites

    private func animatePresentation(transitionContext: UIViewControllerContextTransitioning) {
        guard
            let toVC = transitionContext.viewController(forKey: .to),
            let fromVC = transitionContext.viewController(forKey: .from)
            else { return }

        let presentable = panModalLayoutType(from: transitionContext)

        fromVC.beginAppearanceTransition(false, animated: true)
        let yPos: CGFloat = presentable?.shortFormYPos ?? 0.0
        let panView: UIView = transitionContext.containerView.panContainerView ?? toVC.view
        panView.frame = transitionContext.finalFrame(for: toVC)
        panView.frame.origin.y = transitionContext.containerView.frame.height

        // swiftlint:disable multiple_closures_with_trailing_closure
        BottomSheetModalAnimator.animate({
            panView.frame.origin.y = yPos
        }, config: presentable) { didComplete in
            fromVC.endAppearanceTransition()
            transitionContext.completeTransition(didComplete)
        }
    }

    private func animateDismissal(transitionContext: UIViewControllerContextTransitioning) {
        guard
            let toVC = transitionContext.viewController(forKey: .to),
            let fromVC = transitionContext.viewController(forKey: .from)
            else { return }

        toVC.beginAppearanceTransition(true, animated: true)
        
        let presentable = panModalLayoutType(from: transitionContext)
        let panView: UIView = transitionContext.containerView.panContainerView ?? fromVC.view

        BottomSheetModalAnimator.animate({
            panView.frame.origin.y = transitionContext.containerView.frame.height
        }, config: presentable) { didComplete in
            fromVC.view.removeFromSuperview()
            toVC.endAppearanceTransition()
            transitionContext.completeTransition(didComplete)
        }
    }

    private func panModalLayoutType(from context: UIViewControllerContextTransitioning) -> BottomSheetPresentable.LayoutType? {
        switch transitionStyle {
        case .presentation:
            return context.viewController(forKey: .to) as? BottomSheetPresentable.LayoutType
        case .dismissal:
            return context.viewController(forKey: .from) as? BottomSheetPresentable.LayoutType
        }
    }

}

// MARK: - UIViewControllerAnimatedTransitioning

extension BottomSheetPresentationAnimator: UIViewControllerAnimatedTransitioning {

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        guard
            let context = transitionContext,
            let presentable = panModalLayoutType(from: context)
            else { return BottomSheetModalAnimator.Constants.defaultTransitionDuration }

        return presentable.transitionDuration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        switch transitionStyle {
        case .presentation:
            animatePresentation(transitionContext: transitionContext)
        case .dismissal:
            animateDismissal(transitionContext: transitionContext)
        }
    }

}
