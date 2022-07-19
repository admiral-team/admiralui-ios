//
//  SeparatorViewCustomScheme.swift
//  ExampleiOS
//
//  Created on 12.07.2022.
//

import AdmiralTheme
import AdmiralUIResources

struct SeparatorViewCustomScheme {
    var titleFont: AFont

    var backgroundColor: AColor
    
    init() {
        self.init(theme: AppTheme.default)
    }
    
    init(theme: AppTheme) {
        titleFont = theme.fonts.headline
        backgroundColor = theme.colors.backgroundBasic
    }
}
