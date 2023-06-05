//
//  InputNumberScheme.swift
//  AdmiralUI
//
//  Created on 25.11.2020.
//

import AdmiralTheme
/**
 InputNumberScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - InputNumberScheme() - Initialize default InputNumberScheme with default themezation
Example to create InputNumberScheme:
Code
 ```
let scheme = InputNumberScheme()
 ```
 */
public struct InputNumberScheme: AppThemeScheme {

    // MARK: - Public Properties

    /// The title label font color
    public var titleFont: AFont

    /// The number label font
    public var numberFont: AFont

    /// The text label color
    public var textColor = ControlParameter<AColor>()

    /// The text label tint color
    public var tintColor = ControlParameter<AColor>()

    /// The background color
    public var backgroundColor = ControlParameter<AColor>()

    // MARK: - Initializer

    public init(theme: AppTheme = .default) {
        let alpha = theme.colors.disabledAlpha

        titleFont = theme.fonts.body1
        numberFont = theme.fonts.body1
        
        textColor.set(parameter: theme.colors.textPrimary, for: .normal)
        tintColor.set(parameter: theme.colors.textSecondary, for: .normal)
        backgroundColor.set(parameter: theme.colors.backgroundAdditionalOne, for: .normal)
        
        textColor.set(parameter: theme.colors.textPrimary, for: .highlighted)
        tintColor.set(parameter: theme.colors.textSecondary, for: .highlighted)
        backgroundColor.set(parameter: theme.colors.backgroundAdditionalOnePressed, for: .highlighted)
        
        textColor.set(parameter: theme.colors.textSecondary, for: .disabled)
        tintColor.set(parameter: theme.colors.elementPrimary.withAlpha(alpha), for: .disabled)
        backgroundColor.set(parameter: theme.colors.backgroundAdditionalOne, for: .disabled)
    }
}
