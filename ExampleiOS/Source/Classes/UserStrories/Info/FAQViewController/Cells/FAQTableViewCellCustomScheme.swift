//
//  FAQTableViewCellCustomScheme.swift
//  ExampleiOS
//
//  Created on 22.04.2021.
//

import AdmiralTheme
import AdmiralUIResources

struct FAQTableViewCellCustomScheme {
    var titleLabelFont: AFont
    var subtitleLabelFont: AFont
    
    var backgroundColor: AColor
    var titleLabelTextColor: AColor
    var subtitleLabelTextColor: AColor
    var linkTextColor: AColor
    
    init() {
        self.init(theme: AppTheme.default)
    }
    
    init(theme: AppTheme) {
        backgroundColor = theme.colors.backgroundBasic
        
        titleLabelFont = theme.fonts.body2
        titleLabelTextColor = theme.colors.textPrimary
        
        subtitleLabelFont = theme.fonts.body2
        subtitleLabelTextColor = theme.colors.textPrimary
        
        linkTextColor = theme.colors.textAccent
    }
  
}
