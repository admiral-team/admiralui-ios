//
//  StatusHistoryTitleViewScheme.swift
//  AdmiralUI
//
//  Created on 23.12.2020.
//

import UIKit
import AdmiralTheme
import AdmiralUIResources

struct StatusHistoryTitleViewScheme {
    
    var titleFont: AFont
    var titleColor: AColor
    
    var subtitleFont: AFont
    var subtitleColor: AColor
    
    init() {
        self.init(theme: AppTheme.default)
    }
    
    init(theme: AppTheme) {
        titleFont = theme.fonts.body1
        titleColor = theme.colors.textPrimary
        
        subtitleFont = theme.fonts.body2
        subtitleColor = theme.colors.textSecondary
    }
}
