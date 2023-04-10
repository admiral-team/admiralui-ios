//
//  IconCellCustomScheme.swift
//  ExampleiOS
//
//  Created on 22.04.2021.
//

import AdmiralCore
import AdmiralTheme
import AdmiralUIResources

struct IconCellCustomScheme {
    var titleLabelLabelFont: AFont

    var backgroundColor: AColor
    var titleLabelTextColor: AColor
    var imageViewTintColor: AColor
    
    init() {
        self.init(theme: AppTheme.default)
    }
    
    init(theme: AppTheme) {
        imageViewTintColor = theme.colors.elementAccent
        titleLabelTextColor = theme.colors.textSecondary
        backgroundColor = theme.colors.backgroundBasic
        
        titleLabelLabelFont = theme.fonts.caption1
    }
  
}
