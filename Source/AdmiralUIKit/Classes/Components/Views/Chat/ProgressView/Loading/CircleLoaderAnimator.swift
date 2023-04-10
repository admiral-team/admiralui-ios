//
//  CircleLoaderAnimator.swift
//  AdmiralUIKit
//
//  Created on 23.01.2022.
//

import AdmiralCore
import AdmiralTheme
import AdmiralUIResources
import UIKit

final class CircleLoaderAnimator {

    enum Animation: String {
        var key: String {
            return rawValue
        }
        case rotation = "material.indicator.rotation"
    }

    public func addAnimation(to layer: CALayer) {
        layer.add(rotationAnimation(), forKey: Animation.rotation.key)
    }

    public func removeAnimation(from layer: CALayer) {
        layer.removeAnimation(forKey: Animation.rotation.key)
    }

}

extension CircleLoaderAnimator {

    private func rotationAnimation() -> CABasicAnimation {
        let animation = CABasicAnimation(key: .rotationZ)
        animation.fromValue = 0.0
        animation.toValue = CGFloat.pi * 2
        animation.isRemovedOnCompletion = false
        animation.duration = 1.0
        animation.repeatCount = Float.infinity
        return animation
    }

}
