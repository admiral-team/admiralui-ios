//
//  MenuInfoCellCustomScheme.swift
//  ExampleiOS
//
//  Created on 22.04.2021.
//

import AdmiralTheme

struct MenuInfoCellCustomScheme {
    var titleFont: AFont

    var textColor: AColor
    var backgroundColor: AColor
    var imageTintColor: AColor
    
    init() {
        self.init(theme: AppTheme.default)
    }
    
    init(theme: AppTheme) {
        titleFont = theme.fonts.body1
        textColor = theme.colors.textPrimary
        backgroundColor = theme.colors.backgroundBasic
        imageTintColor = theme.colors.elementAccent
    }
}
