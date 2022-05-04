//
//  SpinnerAnimator.swift
//  AdmiralUIResources
//
//  Created on 04.05.2022.
//

import UIKit

final class SpinnerAnimator {

    enum Animation: String {
        case strokeEnd = "strokeEnd"
        case rotation = "transform.rotation"
    }

    struct AnimationStep {
        let seconds: CFTimeInterval
        let start: CGFloat
        let end: CGFloat
    }

    // MARK: - Private Properties

    /// The number of step in animation loop.
    private let steps: [AnimationStep]

    /// The start time
    private var time: CFTimeInterval = 0

    /// The time for each KeyFrame
    private var times = [CFTimeInterval]()
    private var start: CGFloat = 0

    /// The KeyFrame values
    private var rotationsPoints = [CGFloat]()
    private var endPoints = [CGFloat]()

    /// Animation time total count.
    private var totalSeconds: Double {
        steps.reduce(0) { $0 + $1.seconds }
    }

    // MARK: - Initializer

    init() {
        steps = [
            AnimationStep(seconds: 0.0, start: 0.0, end: 0.15),
            AnimationStep(seconds: 0.6, start: 0.15, end: 0.9),
            AnimationStep(seconds: 0.6, start: 1.0, end: 0.3),
            AnimationStep(seconds: 0.6, start: 1.5, end: 0.1),
            AnimationStep(seconds: 0.2, start: 1.8, end: 0.1),
            AnimationStep(seconds: 0.2, start: 2.2, end: 0.3),
            AnimationStep(seconds: 0.2, start: 2.6, end: 0.5),
            AnimationStep(seconds: 0.2, start: 3.0, end: 0.15),
        ]
        setup()
    }

    // MARK: - Private Methods

    /// Calculating points for animation loop.
    private func setup() {
        for step in steps {
            time += step.seconds
            times.append(time / totalSeconds)
            start = step.start
            rotationsPoints.append(start * 2 * .pi)
            endPoints.append(step.end)
        }

        guard let lastTime = times.last,
              let firstRotation = rotationsPoints.first,
              let firstEndPoint = endPoints.first
        else {
            return
        }

        times.append(lastTime)
        rotationsPoints.append(firstRotation)
        endPoints.append(firstEndPoint)
    }

    // MARK: - Internal Methods

    func addAnimation(to layer: CALayer) {
        let startAnimation = animateKeyPath(keyPath: Animation.strokeEnd.rawValue, values: endPoints)
        let rorationAnimation = animateKeyPath(keyPath: Animation.rotation.rawValue, values: rotationsPoints)

        layer.add(startAnimation, forKey: startAnimation.keyPath)
        layer.add(rorationAnimation, forKey: rorationAnimation.keyPath)
    }

    func removeAnimation(from layer: CALayer) {
        layer.removeAnimation(forKey: Animation.strokeEnd.rawValue)
        layer.removeAnimation(forKey: Animation.rotation.rawValue)
    }
}

// MARK: - Animation

private extension SpinnerAnimator {

    func animateKeyPath(keyPath: String, values: [CGFloat]) -> CAKeyframeAnimation {
        let animation = CAKeyframeAnimation(keyPath: keyPath)
        animation.keyTimes = times as [NSNumber]?
        animation.values = values
        animation.calculationMode = .linear
        animation.duration = totalSeconds
        animation.repeatCount = Float.infinity
        return animation
    }

}
