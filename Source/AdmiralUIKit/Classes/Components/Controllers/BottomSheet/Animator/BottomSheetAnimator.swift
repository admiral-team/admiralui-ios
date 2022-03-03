//
//  BottomSheetAnimator.swift
//  AdmiralUI
//
//  Created on 19.01.2021.
//

import UIKit

/// Helper animation function to keep animations consistent.
struct BottomSheetModalAnimator {

    struct Constants {
        static let defaultTransitionDuration: TimeInterval = Durations.Default.double
    }
    
    static func animate(
        _ animations: @escaping BottomSheetPresentable.AnimationBlockType,
        config: BottomSheetPresentable?,
        _ completion: BottomSheetPresentable.AnimationCompletionType? = nil) {
        
        let transitionDuration = config?.transitionDuration ?? Constants.defaultTransitionDuration
        let springDamping = config?.springDamping ?? 1.0
        let animationOptions = config?.transitionAnimationOptions ?? []
        
        UIView.animate(
            withDuration: transitionDuration,
            delay: 0,
            usingSpringWithDamping: springDamping,
            initialSpringVelocity: 0,
            options: animationOptions,
            animations: animations,
            completion: completion)
    }
    
}
