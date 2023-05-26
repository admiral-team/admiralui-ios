//
//  ColorTokerCellCustomSheme.swift
//  ExampleiOS
//
//  Created on 22.04.2021.
//

import AdmiralTheme

struct ColorTokerCellCustomSheme {
    var titleLabelFont: AFont
    var hexLabelFont: AFont
    
    var backgroundColor: AColor
    var titleLabelTextColor: AColor
    var hexLabelTextColor: AColor
    var arrowImageViewTintColor: AColor
    
    init() {
        self.init(theme: AppTheme.default)
    }
    
    init(theme: AppTheme) {
        titleLabelFont = theme.fonts.body1
        hexLabelFont = theme.fonts.subhead3
        
        titleLabelTextColor = theme.colors.textPrimary
        hexLabelTextColor = theme.colors.textSecondary
        backgroundColor = theme.colors.backgroundBasic
        arrowImageViewTintColor = theme.colors.textSecondary
    }
  
}
