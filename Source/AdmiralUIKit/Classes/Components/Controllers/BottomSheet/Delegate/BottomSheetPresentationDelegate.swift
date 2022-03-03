//
//  BottomSheetPresentationDelegate.swift
//  AdmiralUI
//
//  Created on 19.01.2021.
//

import UIKit

open class BottomSheetPresentationDelegate: NSObject {

    /// Returns an instance of the delegate, retained for the duration of presentation
    public static var `default`: BottomSheetPresentationDelegate = {
        return BottomSheetPresentationDelegate()
    }()

}

// MARK: - UIViewControllerTransitioningDelegate

extension BottomSheetPresentationDelegate: UIViewControllerTransitioningDelegate {

    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return BottomSheetPresentationAnimator(transitionStyle: .presentation)
    }

    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return BottomSheetPresentationAnimator(transitionStyle: .dismissal)
    }

    public func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let controller = BottomSheetPresentationController(presentedViewController: presented, presenting: presenting)
        return controller
    }

}
