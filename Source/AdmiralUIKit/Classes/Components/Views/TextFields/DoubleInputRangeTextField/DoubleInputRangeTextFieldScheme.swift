//
//  DoubleInputRangeTextFieldScheme.swift
//  AdmiralUIKit
//
//  Created on 18.11.2021.
//

import AdmiralTheme
import AdmiralUIResources

/**
 DoubleInputRangeTextFieldScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - DoubleInputRangeTextFieldScheme() - Initialize default DoubleInputRangeTextFieldScheme with default themezation
Example to create DoubleInputRangeTextFieldScheme:
Code
 ```
let scheme = DoubleInputRangeTextFieldScheme()
 ```
 */
public struct DoubleInputRangeTextFieldScheme: AppThemeScheme {

    /// Slider scheme.
    public var sliderScheme: SliderScheme

    /// Text field scheme.
    public var textFieldScheme: TextFieldScheme

    /// Value font.
    public var valueFont: AFont

    public init(theme: AppTheme = .default) {
        self.valueFont = theme.fonts.subhead3
        self.textFieldScheme = TextFieldScheme(theme: theme)
        self.sliderScheme = SliderScheme(theme: theme)
    }
}
