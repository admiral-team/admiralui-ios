//
//  ButtonListViewScheme.swift
//  AdmiralUI
//
//  Created on 27.11.2020.
//

import AdmiralTheme

/**
 ButtonListViewScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - ButtonListViewScheme() - Initialize default ButtonListViewScheme with default themezation
Example to create ButtonListViewScheme:
Code
 ```
let scheme = ButtonListViewScheme()
 ```
 */
public struct ButtonListViewScheme: AppThemeScheme {

    /// Background color.
    public var backgroundColor = ControlParameter<AColor>()

    /// Button text color.
    public var buttonTextColor = ControlParameter<AColor>()

    /// Button background color.
    public var buttonBackgroundColor = ControlParameter<AColor>()

    /// Button font.
    public var buttonFont: AFont
    
    public init(theme: AppTheme = .default) {
        let alpha = theme.colors.disabledAlpha

        backgroundColor.set(parameter: theme.colors.backgroundSelected, for: .highlighted)
        backgroundColor.set(parameter: theme.colors.backgroundBasic, for: .normal)
        
        buttonTextColor.set(parameter: theme.colors.textAccent, for: .normal)
        buttonTextColor.set(parameter: theme.colors.textAccentPressed, for: .selected)
        buttonTextColor.set(parameter: theme.colors.textAccentPressed, for: .highlighted)
        buttonTextColor.set(parameter: theme.colors.textAccent.withAlpha(alpha), for: .disabled)
        
        buttonBackgroundColor.set(parameter: theme.colors.backgroundBasic, for: .normal)
        buttonBackgroundColor.set(parameter: theme.colors.backgroundAccent, for: .highlighted)
        buttonBackgroundColor.set(parameter: theme.colors.backgroundAccent, for: .selected)
        
        buttonFont = theme.fonts.body1
    }
}
