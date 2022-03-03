//
//  InformersViewScheme.swift
//  ExampleiOS
//
//  Created on 22.04.2021.
//

import AdmiralTheme
import AdmiralUIResources

struct InformersViewScheme {
    var titleFont: AFont

    var textColor: AColor
    var backgroundColor: AColor
    
    init() {
        self.init(theme: AppTheme.default)
    }
    
    init(theme: AppTheme) {
        titleFont = theme.fonts.headline
        textColor = theme.colors.textSecondary
        backgroundColor = theme.colors.backgroundBasic
    }
}
