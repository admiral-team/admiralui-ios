//
//  Shimmer.swift
//  AdmiralUI
//
//  Created on 16.12.2020.
//

import UIKit

final public class Shimmer {

    public enum Direction {
        case right
        case left
        case up
        case down
    }

    struct Key {
        static let slideAnimation = "slide"
        static let fadeAnimation = "fade"
        static let endFadeAnimation = "fade-end"
    }

    static func fadeAnimation(layer: CALayer, opacity: CGFloat, duration: CFTimeInterval) -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.fromValue = layer.presentation()?.opacity
        animation.toValue = opacity
        animation.fillMode = .both
        animation.isRemovedOnCompletion = false
        animation.duration = duration
        return animation
    }

    static func slideAnimation(duration: CFTimeInterval, direction: Direction) -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "position")
        animation.toValue = NSValue(cgPoint: .zero)
        animation.duration = duration
        animation.repeatCount = .greatestFiniteMagnitude
        if direction == .left || direction == .up {
            animation.speed = -fabsf(animation.speed)
        }
        return animation
    }

    static func slideRepeat(animation: CAAnimation, duration: CFTimeInterval, direction: Direction) -> CAAnimation {
        guard let anim = animation.copy() as? CAAnimation else { return CAAnimation() }
        anim.repeatCount = .greatestFiniteMagnitude
        anim.duration = duration
        anim.speed = (direction == .right || direction == .down) ? fabsf(anim.speed) : -fabsf(anim.speed)
        return anim
    }

    static func slideFinish(animation: CAAnimation) -> CAAnimation {
        guard let anim = animation.copy() as? CAAnimation else { return CAAnimation() }
        anim.repeatCount = 0
        return anim
    }

}
