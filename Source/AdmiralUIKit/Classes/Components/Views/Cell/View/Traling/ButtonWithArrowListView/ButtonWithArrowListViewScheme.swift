//
//  ButtonWithArrowListViewScheme.swift
//  AdmiralUI
//
//  Created on 27.11.2020.
//

import AdmiralCore
import AdmiralTheme
import AdmiralUIResources

/**
 ButtonWithArrowListViewScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - ButtonWithArrowListViewScheme() - Initialize default ButtonWithArrowListViewScheme with default themezation
Example to create ButtonWithArrowListViewScheme:
Code
 ```
let scheme = ButtonWithArrowListViewScheme()
 ```
 */
public struct ButtonWithArrowListViewScheme: AppThemeScheme {

    /// Background color.
    public var backgroundColor = ControlParameter<AColor>()

    /// Button text color.
    public var buttonTextColor = ControlParameter<AColor>()

    /// Button background color.
    public var buttonBackgroundColor = ControlParameter<AColor>()

    /// Arrow image tint color.
    public var arrowImageTintColor = ControlParameter<AColor>()

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
        
        buttonBackgroundColor.set(parameter: .clear, for: .normal)
        buttonBackgroundColor.set(parameter: .clear, for: .highlighted)
        buttonBackgroundColor.set(parameter: .clear, for: .selected)
        
        arrowImageTintColor.set(parameter: theme.colors.elementAccent, for: .normal)
        arrowImageTintColor.set(parameter: theme.colors.elementAccent.withAlpha(alpha), for: .disabled)
        
        buttonFont = theme.fonts.body1
    }
}
