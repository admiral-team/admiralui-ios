//
//  ContactsTableViewCustomTheme.swift
//  ExampleiOS
//
//  Created on 22.04.2021.
//

import AdmiralCore
import AdmiralTheme
import AdmiralUIResources

struct ContactsTableViewCustomTheme {
    var titleLabelFont: AFont
    var subtitleLabelFont: AFont
    var additionalLabelFont: AFont
    
    var backgroundColor: AColor
    var titleLabelTextColor: AColor
    var subtitleLabelFontTextColor: AColor
    var additionalLabelTextColor: AColor
    
    init() {
        self.init(theme: AppTheme.default)
    }
    
    init(theme: AppTheme) {
        backgroundColor = theme.colors.backgroundBasic
        titleLabelFont = theme.fonts.body1
        subtitleLabelFont = theme.fonts.subhead4
        additionalLabelFont = theme.fonts.body1
        
        titleLabelTextColor = theme.colors.textPrimary
        subtitleLabelFontTextColor = theme.colors.textPrimary
        additionalLabelTextColor = theme.colors.textAccent
    }
    
}
