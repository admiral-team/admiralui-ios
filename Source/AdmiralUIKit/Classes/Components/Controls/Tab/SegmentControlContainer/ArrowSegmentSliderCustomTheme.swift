//
//  ArrowSegmentSliderCustomTheme.swift
//  AdmiralUI
//
//  Created on 08.02.2021.
//

import AdmiralTheme

/**
 ArrowSegmentSliderCustomTheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - ArrowSegmentSliderCustomTheme() - Initialize default ArrowSegmentSliderCustomTheme with default themezation
Example to create ArrowSegmentSliderCustomTheme:
Code
 ```
let scheme = ArrowSegmentSliderCustomTheme()
 ```
 */
public struct ArrowSegmentSliderCustomTheme: AppThemeScheme {

    /// Image tint color.
    public var imageTintColor: AColor

    /// Background color.
    public var backgroundColor: AColor
    
    public init(theme: AppTheme = .default) {
        backgroundColor = .clear
        imageTintColor = theme.colors.backgroundAdditionalOne
    }
}
