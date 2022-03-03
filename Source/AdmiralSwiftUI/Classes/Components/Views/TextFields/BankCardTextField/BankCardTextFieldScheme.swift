//
//  BankCardTextFieldStyle.swift
//  AdmiralSwiftUI
//
//  Created on 25.05.2021.
//

import AdmiralTheme
import AdmiralUIResources

public struct BankCardTextFieldScheme: AppThemeScheme {
    
    public var tintColor: AColor
    public var textColor: AColor
    public var errorColor: AColor
    public var disabledColor: AColor
    public var underlineColor: AColor
    public var placeholderColor: AColor
    
    public var textFieldFont: AFont
    public var placeholderFont: AFont
    public var informerFont: AFont
    
    public init() {
        self.init(theme: AppTheme.default)
    }
    
    public init(theme: AppTheme) {
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
