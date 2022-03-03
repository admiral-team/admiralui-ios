//
//  TextViewScheme.swift
//  AdmiralUI
//
//  Created on 11.03.2021.
//

import AdmiralTheme
import AdmiralUIResources

struct TextViewScheme {
    
    var tintColor: AColor
    var textColor: AColor
    var errorColor: AColor
    var disabledColor: AColor
    var underlineColor: AColor
    var placeholderColor: AColor
    
    var nameFont: AFont
    var textFieldFont: AFont
    var placeholderFont: AFont
    var informerFont: AFont
    var nameLabelMinFont: AFont
    
    init() {
        self.init(theme: AppTheme.default)
    }
    
    init(theme: AppTheme) {
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
