//
//  OTPTextFieldScheme.swift
//  AdmiralUI
//
//  Created on 25.11.2020.
//

import AdmiralTheme
import AdmiralUIResources

struct OTPTextFieldScheme {
    
    var tintColor: AColor
    var textColor: AColor
    var errorColor: AColor
    var disabledColor: AColor
    var underlineColor: AColor
    var placeholderColor: AColor
    
    var textFieldFont: AFont
    var placeholderFont: AFont
    var informerFont: AFont
    
    init() {
        self.init(theme: AppTheme.default)
    }
    
    init(theme: AppTheme) {
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
