//
//  StatusHistoryDateViewScheme.swift
//  AdmiralUI
//
//  Created on 23.12.2020.
//

import AdmiralTheme
import AdmiralUIResources

struct StatusHistoryDateViewScheme {
    
    var textFont: AFont
    var textColor: AColor
    
    var buttonTintColor: AColor
    
    init() {
        self.init(theme: AppTheme.default)
    }
    
    init(theme: AppTheme) {
        textFont = theme.fonts.body2
        textColor = theme.colors.textPrimary
        buttonTintColor = theme.colors.textSecondary
    }
}
