//
//  InputNumberTextFieldScheme.swift
//  AdmiralUIKit
//
//  Created by on 24.10.2022.
//  
//

import AdmiralCore
import AdmiralTheme
/**
 InputNumberTextFieldScheme - the visual scheme of InputNumber.
 You can create a by specifying the following parameters in init:
 - InputNumberTextFieldScheme() - Initialize default InputNumberTextFieldScheme with default themezation
 # Example to create InputNumberTextFieldScheme:
 ```
let scheme = InputNumberTextFieldScheme()
 ```
 */
public struct InputNumberTextFieldScheme: AppThemeScheme {

    // MARK: - Public Properties

    /// Title label font
    public var titleFont: AFont

    /// Textfield scheme
    public var textField: TextFieldScheme

    /// Title label color
    public var titleLabelColor = ControlParameter<AColor>()

    /// Text field background color
    public var textFieldBackground = ControlParameter<AColor>()

    /// Button background color
    public var buttonBackgroundColor = ControlParameter<AColor>()

    // MARK: - Initializer

    public init(theme: AppTheme = .default) {
        let alpha = theme.colors.disabledAlpha
        titleFont = theme.fonts.body1

        textField = TextFieldScheme(theme: theme)

        buttonBackgroundColor.set(parameter: theme.colors.backgroundAdditionalOne, for: .normal)
        buttonBackgroundColor.set(parameter: theme.colors.backgroundAdditionalOnePressed, for: .highlighted)
        buttonBackgroundColor.set(parameter: theme.colors.backgroundAdditionalOne, for: .disabled)

        titleLabelColor.set(parameter: theme.colors.textPrimary, for: .normal)
        titleLabelColor.set(parameter: theme.colors.textPrimary, for: .highlighted)
        titleLabelColor.set(parameter: theme.colors.textSecondary, for: .disabled)

        textFieldBackground.set(parameter: theme.colors.backgroundAdditionalOne, for: .normal)
        textFieldBackground.set(parameter: theme.colors.backgroundAdditionalOnePressed, for: .highlighted)
        textFieldBackground.set(parameter: theme.colors.backgroundAdditionalOne.withAlpha(alpha), for: .disabled)
    }

}
