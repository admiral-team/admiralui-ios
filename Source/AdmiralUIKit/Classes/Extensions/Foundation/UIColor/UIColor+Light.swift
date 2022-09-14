//
//  UIColor+Light.swift
//  AdmiralUI
//
//  Created on 13.10.2020.
//

import UIKit

public extension UIColor {

    /// Check if the color is light or dark
    ///
    /// - Parameter threshold: Injected lightness threshold.
    /// - Returns: true - color is light, false - color is dark.
    func isLight(threshold: Float = 0.5) -> Bool? {
        let originalCGColor = self.cgColor

        let RGBCGColor = originalCGColor.converted(
            to: CGColorSpaceCreateDeviceRGB(),
            intent: .defaultIntent,
            options: nil)

        guard let components = RGBCGColor?.components else {
            return nil
        }

        guard components.count >= 3 else {
            return nil
        }

        let brightness = Float(((components[0] * 299) + (components[1] * 587) + (components[2] * 114)) / 1000)

        return (brightness > threshold)
    }

}
