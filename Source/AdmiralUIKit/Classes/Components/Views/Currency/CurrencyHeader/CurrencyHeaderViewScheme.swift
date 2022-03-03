//
//  CurrencyHeaderViewScheme.swift
//  AdmiralUIKit
//
//  Created on 21.02.2022.
//

import AdmiralTheme
import AdmiralUIResources

struct CurrencyHeaderViewScheme: AppThemeScheme {

    // MARK: - Internal Properties

    var textColor: AColor
    var textFont: AFont
    var backgroundColor: AColor

    // MARK: - Initializer

    init() {
        self.init(theme: AppTheme.default)
    }

    init(theme: AppTheme) {
        backgroundColor = theme.colors.backgroundBasic
        textColor = theme.colors.textSecondary
        textFont = theme.fonts.subhead3
    }
}
