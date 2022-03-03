//
//  SectionHeaderCustomScheme.swift
//  ExampleiOS
//
//  Created on 22.04.2021.
//

import AdmiralTheme
import AdmiralUIResources

struct SectionHeaderCustomScheme {
    var titleLabelLabelFont: AFont

    var backgroundColor: AColor
    var titleLabelTextColor: AColor
    
    init() {
        self.init(theme: AppTheme.default)
    }
    
    init(theme: AppTheme) {
        titleLabelTextColor = theme.colors.textSecondary
        backgroundColor = theme.colors.backgroundBasic
        
        titleLabelLabelFont = theme.fonts.headline
    }
  
}
