//
//  DoubleInputRangeTextFieldScheme.swift
//  AdmiralSwiftUI
//
//  Created on 29.09.2021.
//

import AdmiralTheme
/**
 DoubleSliderScheme - the visual scheme of Slider.
 You can create a by specifying the following parameters in init:
 - DoubleSliderScheme() - Initialize default DoubleSliderScheme with default themezation
 # Example to create DoubleSliderScheme:
 # Code
 ```
 let scheme = DoubleSliderScheme()
 ```
 */
@available(iOS 14.0, *)
public struct DoubleInputRangeTextFieldScheme: AppThemeScheme {

    // MARK: - Public Properties

    /// The slider scheme
    public var slider: SliderScheme

    /// The text field scheme
    public var textField: StandardTextFieldScheme

    /// The value label font
    public var valueFont: AFont

    /// The text font label
    public var textFont: AFont

    /// The text color label
    public var textColor: AColor

    // MARK: - Initializer

    public init(theme: AppTheme = .default) {
        self.valueFont = theme.fonts.subhead3
        self.textField = StandardTextFieldScheme(theme: theme)
        self.slider = SliderScheme(theme: theme)
        
        self.textFont = theme.fonts.body1
        self.textColor = theme.colors.textSecondary
    }
}
