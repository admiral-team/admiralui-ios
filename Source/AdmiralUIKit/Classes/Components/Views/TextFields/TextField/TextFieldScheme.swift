//
//  TextFieldScheme.swift
//  AdmiralUI
//
//  Created on 24.11.2020.
//

import AdmiralTheme
import AdmiralUIResources

struct TextFieldScheme {
    
    var tintColor: AColor
    var textColor: AColor
    var errorColor: AColor
    var disabledColor: AColor
    var underlineColor: AColor
    var placeholderColor: AColor
    
    var textFieldFont: AFont
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

        textFieldFont = theme.fonts.body1
        informerFont = theme.fonts.subhead3
    }
    
}
