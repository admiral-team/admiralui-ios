//
//  MapButtonsScheme.swift
//  ExampleiOS
//
//  Created on 18.02.2022.
//

import AdmiralTheme
import CoreGraphics

struct MapButtonCellScheme: AppThemeScheme {

    var backgroundColor: AColor
    var titleLabelFont: AFont
    var titleLabelTextColor: AColor

    init() {
        self.init(theme: AppTheme.default)
    }

    init(theme: AppTheme) {
        titleLabelFont = theme.fonts.headline
        titleLabelTextColor = theme.colors.textSecondary
        backgroundColor = theme.colors.backgroundAdditionalOne
    }

}
