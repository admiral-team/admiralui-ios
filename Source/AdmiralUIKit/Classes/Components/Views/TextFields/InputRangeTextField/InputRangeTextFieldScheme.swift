//
//  InputRangeTextFieldScheme.swift
//  AdmiralUI
//
//  Created on 25.11.2020.
//

import AdmiralTheme

/**
 InputRangeTextFieldScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - InputRangeTextFieldScheme() - Initialize default InputRangeTextFieldScheme with default themezation
Example to create InputRangeTextFieldScheme:
Code
 ```
let scheme = InputRangeTextFieldScheme()
 ```
 */
public struct InputRangeTextFieldScheme: AppThemeScheme {

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
