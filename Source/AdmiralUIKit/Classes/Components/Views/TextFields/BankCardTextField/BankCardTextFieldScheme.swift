//
//  BankCardTextFieldScheme.swift
//  AdmiralUI
//
//  Created on 25.11.2020.
//

import AdmiralTheme

/**
 BankCardTextFieldScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - BankCardTextFieldScheme() - Initialize default BankCardTextFieldScheme with default themezation
Example to create BankCardTextFieldScheme:
Code
 ```
let scheme = BankCardTextFieldScheme()
 ```
 */
public struct BankCardTextFieldScheme: AppThemeScheme {

    /// Tint color.
    public var tintColor: AColor

    /// Text color.
    public var textColor: AColor

    /// Error color.
    public var errorColor: AColor

    /// Disabled color.
    public var disabledColor: AColor

    /// Underline color.
    public var underlineColor: AColor

    /// Placeholder color.
    public var placeholderColor: AColor

    /// Text field font.
    public var textFieldFont: AFont

    /// Placeholder font.
    public var placeholderFont: AFont

    /// Informer font.
    public var informerFont: AFont
    
    public init(theme: AppTheme = .default) {
        let alpha = theme.colors.disabledAlpha

        tintColor = theme.colors.elementAccent
        textColor = theme.colors.textPrimary
        errorColor = theme.colors.textError
        disabledColor = theme.colors.textSecondary.withAlpha(alpha)
        underlineColor = theme.colors.textSecondary
        placeholderColor = theme.colors.textSecondary.withAlpha(alpha)
        
        textFieldFont = theme.fonts.title2
        placeholderFont = theme.fonts.title2
        informerFont = theme.fonts.subhead3
    }
    
}
