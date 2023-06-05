//
//  MainTitleTableViewCellCustomScheme.swift
//  ExampleiOS
//
//  Created on 23.04.2021.
//

import AdmiralTheme
import UIKit

struct MainTitleTableViewCellCustomScheme {
    
    var titleLabelFont: AFont
    var subtitleLabelFont: AFont
    var titleLabelTextColor: AColor
    var subtitleLabelTextColor: AColor
    var backgroundColor: AColor
    
    init() {
        self.init(theme: AppTheme.default)
    }
    
    init(theme: AppTheme) {
        titleLabelFont = theme.fonts.body1
        subtitleLabelFont = theme.fonts.subhead4
        
        titleLabelTextColor = theme.colors.textPrimary
        subtitleLabelTextColor = theme.colors.textAccent
        
        backgroundColor = theme.colors.backgroundBasic
    }

}
