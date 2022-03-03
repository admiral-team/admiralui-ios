//
//  CalendarHeaderViewScheme.swift
//  AdmiralUI
//
//  Created on 01.12.2020.
//

import AdmiralTheme
import AdmiralUIResources

struct CalendarHeaderViewScheme {
    var titleLabelColor: AColor
    var backgroundColor: AColor
    var titleLabelFont: AFont
    
    init() {
        self.init(theme: AppTheme.default)
    }
    
    init(theme: AppTheme) {
        titleLabelFont = theme.fonts.subtitle1
        
        backgroundColor = theme.colors.backgroundBasic
        titleLabelColor = theme.colors.textPrimary
    }
    
}
