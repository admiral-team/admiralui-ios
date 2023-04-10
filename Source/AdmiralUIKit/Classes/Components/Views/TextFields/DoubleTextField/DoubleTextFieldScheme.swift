//
//  DoubleTextFieldScheme.swift
//  AdmiralUI
//
//  Created on 25.11.2020.
//

import AdmiralCore
import AdmiralTheme
import AdmiralUIResources

/**
 DoubleTextFieldScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - DoubleTextFieldScheme() - Initialize default DoubleTextFieldScheme with default themezation
Example to create DoubleTextFieldScheme:
Code
 ```
let scheme = DoubleTextFieldScheme()
 ```
 */
public struct DoubleTextFieldScheme: AppThemeScheme {

    /// First text field scheme.
    public var first: TextFieldScheme

    /// Seconde text field scheme.
    public var second: TextFieldScheme

    /// Error color scheme.
    public var errorColor: AColor

    /// Underline color.
    public var underlineColor: AColor

    /// Dissabled color.
    public var disabledColor: AColor

    /// Informer font.
    public var informerFont: AFont

    public init(theme: AppTheme = .default) {
        let alpha = theme.colors.disabledAlpha

        self.informerFont = theme.fonts.subhead3
    
        self.first = TextFieldScheme(theme: theme)
        self.second = TextFieldScheme(theme: theme)
        
        self.errorColor = theme.colors.textError
        self.underlineColor = theme.colors.textSecondary
        self.disabledColor = theme.colors.textSecondary.withAlpha(alpha)
    }
}
