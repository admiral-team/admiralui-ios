//
//  MainTableViewCellCustomScheme.swift
//  ExampleiOS
//
//  Created on 23.04.2021.
//

import AdmiralTheme
import UIKit

struct MainTableViewCellCustomScheme {
    
    var titleLabelFont: AFont
    var subtitleLabelFont: AFont
    var titleLabelTextColor: AColor
    var subtitleLabelTextColor: AColor
    var backgroundColor: AColor
    var imageViewTintColor: AColor
    var imageViewContrainerViewTintColor: AColor
    
    init() {
        self.init(theme: AppTheme.default)
    }
    
    init(theme: AppTheme) {
        titleLabelFont = theme.fonts.body1
        subtitleLabelFont = theme.fonts.subhead4
        
        titleLabelTextColor = theme.colors.textPrimary
        subtitleLabelTextColor = theme.colors.textSecondary
        
        backgroundColor = theme.colors.backgroundBasic
        imageViewTintColor = theme.colors.elementAccent
        imageViewContrainerViewTintColor = theme.colors.backgroundAdditionalOne
    }

}
