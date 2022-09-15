//
//  InputRangeTextFieldScheme.swift
//  AdmiralSwiftUI
//
//  Created on 27.05.2021.
//

import AdmiralTheme
import AdmiralUIResources
/**
 InputRangeTextFieldScheme - the visual scheme of InputRangeTextField.
 You can create a by specifying the following parameters in init:
 - InputRangeTextFieldScheme() - Initialize default InputRangeTextFieldScheme with default themezation
 # Example to create InputRangeTextFieldScheme:
 # Code
 ```
 let scheme = InputRangeTextFieldScheme()
 ```
 */
@available(iOS 14.0, *)
public struct InputRangeTextFieldScheme: AppThemeScheme {

    // MARK: - Public Properties

    /// The slider Scheme
    public var sliderScheme: SliderScheme

    /// The text field scheme
    public var textFieldScheme: StandardTextFieldScheme

    /// The font
    public var valueFont: AFont

    // MARK: - Initializer

    public init(theme: AppTheme = .default) {
        self.valueFont = theme.fonts.subhead3
        self.textFieldScheme = StandardTextFieldScheme(theme: theme)
        self.sliderScheme = SliderScheme(theme: theme)
    }
}
