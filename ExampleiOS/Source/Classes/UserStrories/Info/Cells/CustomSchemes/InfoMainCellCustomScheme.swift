//
//  InfoMainCellCustomScheme.swift
//  ExampleiOS
//
//  Created on 22.04.2021.
//

import AdmiralCore
import AdmiralTheme
import AdmiralUIResources

struct InfoMainCellCustomScheme {
    var titleFont: AFont

    var textColor: AColor
    var backgroundColor: AColor
    
    init() {
        self.init(theme: AppTheme.default)
    }
    
    init(theme: AppTheme) {
        titleFont = theme.fonts.body2
        textColor = theme.colors.textPrimary
        backgroundColor = theme.colors.backgroundBasic
    }
}
