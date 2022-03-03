//
//  CurrencyViewScheme.swift
//  AdmiralUIKit
//
//  Created on 21.02.2022.
//

import AdmiralTheme
import AdmiralUIResources

struct CurrencyViewScheme: AppThemeScheme {

    // MARK: - Internal properties

    var textColor: AColor
    var textFont: AFont
    var imageTintColor: AColor
    var backgroundColor: AColor

    // MARK: - Initializer

    init() {
        self.init(theme: AppTheme.default)
    }

    init(theme: AppTheme) {
        backgroundColor = theme.colors.backgroundBasic
        textColor = theme.colors.textPrimary
        imageTintColor = theme.colors.elementPrimary
        textFont = theme.fonts.body1
    }
}

