//
//  BadgeCellViewCustomScheme.swift
//  ExampleiOS
//
//  Created on 22.04.2021.
//

import AdmiralCore
import AdmiralTheme
import AdmiralUIResources

struct BadgeCellViewCustomScheme {
    var titleFont: AFont

    var textColor: AColor
    var backgroundColor: AColor
    var contentViewColor: AColor
    var imageViewColor: AColor
    
    init() {
        self.init(theme: AppTheme.default)
    }
    
    init(theme: AppTheme) {
        titleFont = theme.fonts.headline
        textColor = theme.colors.textSecondary
        backgroundColor = theme.colors.backgroundBasic
        contentViewColor = theme.colors.backgroundAdditionalOne
        imageViewColor = theme.colors.elementAccent
    }
}
