//
//  UIFont+Extensions.swift
//  AdmiralCore
//
//  Created by on 14.11.2022.
//  
//

import UIKit

public extension UIFont {
    var monospacedDigitFont: UIFont {
        let newFontDescriptor = fontDescriptor.monospacedDigitFontDescriptor
        return UIFont(descriptor: newFontDescriptor, size: 0)
    }
}

private extension UIFontDescriptor {
    var monospacedDigitFontDescriptor: UIFontDescriptor {
        let fontDescriptorFeatureSettings = [
            [
                UIFontDescriptor.FeatureKey.featureIdentifier: kNumberSpacingType,
                UIFontDescriptor.FeatureKey.typeIdentifier: kMonospacedNumbersSelector
            ]
        ]

        let fontDescriptorAttributes = [
            UIFontDescriptor.AttributeName.featureSettings: fontDescriptorFeatureSettings
        ]

        let fontDescriptor = addingAttributes(fontDescriptorAttributes)
        return fontDescriptor
    }
}
