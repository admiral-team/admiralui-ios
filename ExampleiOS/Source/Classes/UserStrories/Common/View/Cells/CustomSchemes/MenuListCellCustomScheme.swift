//
//  MenuListCellCustomScheme.swift
//  ExampleiOS
//
//  Created on 23.04.2021.
//

import AdmiralCore
import AdmiralTheme
import AdmiralUIResources
import UIKit

struct MenuListCellCustomScheme {
    
    var titleLabelFont: AFont
    var subtitleLabelFont: AFont
    var imageViewTintColor: AColor
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
        subtitleLabelTextColor = theme.colors.textSecondary
        
        imageViewTintColor = theme.colors.textSecondary
        
        backgroundColor = theme.colors.backgroundBasic
    }

}
