//
//  SeparatorViewCustomScheme.swift
//  ExampleiOS
//
//  Created on 12.07.2022.
//

import AdmiralCore
import AdmiralTheme
import AdmiralUIResources

struct TextBlocksCustomScheme {
    var titleFont: AFont
    var titleColor: AColor
    var backgroundColor: AColor
    
    init() {
        self.init(theme: AppTheme.default)
    }
    
    init(theme: AppTheme) {
        titleFont = theme.fonts.headline
        titleColor = theme.colors.textSecondary
        backgroundColor = theme.colors.backgroundBasic
    }
}
