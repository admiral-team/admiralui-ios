//
//  TextFieldScheme.swift
//  AdmiralUI
//
//  Created on 24.11.2020.
//

import AdmiralTheme
import AdmiralUIResources
/**
 TextFieldScheme - the visual scheme of InputNumber.
 You can create a by specifying the following parameters in init:
 - TextFieldScheme() - Initialize default TextFieldScheme with default themezation
 # Example to create TextFieldScheme:
 ```
let scheme = TextFieldScheme()
 ```
 */
public struct TextFieldScheme {

    // MARK: - Public Properties

    /// Tint  color
    public var tintColor: AColor

    /// Text color
    public var textColor: AColor

    /// Error color
    public var errorColor: AColor

    /// Disabled color
    public var disabledColor: AColor

    /// Separator color
    public var underlineColor: AColor

    /// Placeholder label color
    public var placeholderColor: AColor

    /// Text field font
    public var textFieldFont: AFont

    /// Informer label font 
    public var informerFont: AFont

    // MARK: - Initializer

    public init(theme: AppTheme = .default) {
        let alpha = theme.colors.disabledAlpha

        tintColor = theme.colors.elementAccent
        textColor = theme.colors.textPrimary
        errorColor = theme.colors.textError
        disabledColor = theme.colors.textSecondary.withAlpha(alpha)
        underlineColor = theme.colors.textSecondary
        placeholderColor = theme.colors.textSecondary.withAlpha(alpha)

        textFieldFont = theme.fonts.body1
        informerFont = theme.fonts.subhead3
    }
    
}
