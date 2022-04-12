//
//  ThemeSwitchButtonScheme.swift
//  ExampleiOS
//
//  Created on 11.04.2022.
//

import AdmiralTheme
import AdmiralUIResources

@available(iOS 14.0.0, *)
struct ThemeSwitchButtonScheme: AppThemeScheme {

    // MARK: - Internal Properties

    var backgroundColor: AColor
    var buttonColorSelected: AColor
    var shadowColor: AColor
    var imageColor: AColor

    // MARK: - Initializer

    init(theme: AppTheme) {
        let alpha = theme.colors.disabledAlpha
        buttonColorSelected = theme.colors.elementExtra.withAlpha(alpha)
        backgroundColor = theme.colors.backgroundExtraSurface
        shadowColor = theme.colors.backgroundShadow
        imageColor = theme.colors.elementExtra
    }

}
