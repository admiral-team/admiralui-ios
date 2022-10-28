//
//  InputNumberStyle.swift
//  AdmiralSwiftUI
//
//  Created on 12.05.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources
/**
 InputNumberScheme - the visual scheme of InputNumber.
 You can create a by specifying the following parameters in init:
 - InputNumberScheme() - Initialize default InputNumberScheme with default themezation
 # Example to create InputNumberScheme:
 ```
let scheme = InputNumberScheme()
 ```
 */
@available(iOS 14.0, *)
public final class InputNumberScheme: AppThemeScheme {

    /// The title font
    public var titleFont = ControlParameter<AFont>()

    /// The number font
    public var numberFont = ControlParameter<AFont>()

    /// The text color
    public var textColor = ControlParameter<AColor>()

    /// The tint color
    public var tintColor = ControlParameter<AColor>()

    /// The background color
    public var backgroundColor = ControlParameter<AColor>()

    /// Text field background color
    public var textFieldBackground = ControlParameter<AColor>()

    /// The number font
    public var textFieldFont: AFont

    /// Placeholder text field color.
    public var placeholderColor = ControlParameter<AColor>()

    // MARK: - Initializer

    public init(theme: AppTheme = .default) {
        let alpha = theme.colors.disabledAlpha

        textFieldFont = theme.fonts.body1
        
        titleFont.set(parameter: theme.fonts.body1, for: .normal)
        numberFont.set(parameter: theme.fonts.body1, for: .normal)
        
        textColor.set(parameter: theme.colors.textPrimary, for: .normal)
        tintColor.set(parameter: theme.colors.textSecondary, for: .normal)
        backgroundColor.set(parameter: theme.colors.backgroundAdditionalOne, for: .normal)
        
        textColor.set(parameter: theme.colors.textPrimary, for: .highlighted)
        tintColor.set(parameter: theme.colors.textSecondary, for: .highlighted)
        backgroundColor.set(parameter: theme.colors.backgroundAdditionalOnePressed, for: .highlighted)
        
        textColor.set(parameter: theme.colors.textSecondary, for: .disabled)
        tintColor.set(parameter: theme.colors.elementPrimary.withAlpha(alpha), for: .disabled)
        backgroundColor.set(parameter: theme.colors.backgroundAdditionalOne, for: .disabled)

        textFieldBackground.set(parameter: theme.colors.backgroundAdditionalOne, for: .normal)
        textFieldBackground.set(parameter: theme.colors.backgroundAdditionalOnePressed, for: .highlighted)
        textFieldBackground.set(parameter: theme.colors.backgroundAdditionalOne.withAlpha(alpha), for: .disabled)

        placeholderColor.set(parameter: theme.colors.textMask, for: .normal)
        placeholderColor.set(parameter: theme.colors.textMask.withAlpha(alpha), for: .disabled)
    }
    
}
