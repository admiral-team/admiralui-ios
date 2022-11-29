//
//  TextViewScheme.swift
//  AdmiralUI
//
//  Created on 11.03.2021.
//

import AdmiralTheme
import AdmiralUIResources

/**
 TextViewScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - TextViewScheme() - Initialize default TextViewScheme with default themezation
Example to create TextViewScheme:
Code
 ```
let scheme = TextViewScheme()
 ```
 */
public struct TextViewScheme: AppThemeScheme {

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

    /// Name label font.
    public var nameFont: AFont

    /// Text field font.
    public var textFieldFont: AFont

    /// Placeholder font.
    public var placeholderFont: AFont

    /// Informer font.
    public var informerFont: AFont

    /// Name label min font.
    public var nameLabelMinFont: AFont
    
    public init(theme: AppTheme = .default) {
        let alpha = theme.colors.disabledAlpha

        tintColor = theme.colors.elementAccent
        textColor = theme.colors.textPrimary
        errorColor = theme.colors.textError
        disabledColor = theme.colors.textPrimary.withAlpha(alpha)
        underlineColor = theme.colors.textSecondary
        placeholderColor = theme.colors.textPrimary.withAlpha(alpha)
        
        nameFont = theme.fonts.subhead3
        textFieldFont = theme.fonts.body1
        placeholderFont = theme.fonts.body1
        informerFont = theme.fonts.subhead3
        nameLabelMinFont = theme.fonts.subhead3
    }
    
}
