//
//  AlertControllerCustomScheme.swift
//  ExampleiOS
//
//  Created on 22.04.2021.
//

import AdmiralCore
import AdmiralTheme
import AdmiralUIResources

struct AlertControllerCustomScheme {
    var descriptionLabelFont: AFont

    var descriptionLabelTextColor: AColor
    var backgroundColor: AColor
    
    init() {
        self.init(theme: AppTheme.default)
    }
    
    init(theme: AppTheme) {
        descriptionLabelTextColor = theme.colors.textPrimary
        descriptionLabelFont = theme.fonts.body2
        backgroundColor = theme.colors.backgroundBasic
    }
}
