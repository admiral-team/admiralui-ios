//
//  SearchBarColorScheme.swift
//  AdmiralUI
//
//  Created on 21.02.2021.
//

import AdmiralTheme
import AdmiralUIResources

struct SearchBarColorScheme {
    var textColor: AColor
    var placeholderColor: AColor
    var backgroundColor: AColor
    var tintColor: AColor
    var textFont: AFont
    var placeholderFont: AFont
    
    init() {
        self.init(theme: AppTheme.default)
    }
    
    init(theme: AppTheme) {
        textColor = theme.colors.textPrimary
        placeholderColor = theme.colors.textSecondary
        backgroundColor = theme.colors.backgroundAdditionalOne
        tintColor = theme.colors.elementAccent
        
        textFont = theme.fonts.body2
        placeholderFont = theme.fonts.body2
    }
}
