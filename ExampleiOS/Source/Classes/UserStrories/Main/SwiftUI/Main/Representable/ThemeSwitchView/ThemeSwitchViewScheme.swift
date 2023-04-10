//
//  ThemeSwitchViewScheme.swift
//  ExampleiOS
//
//  Created on 08.04.2022.
//

import AdmiralSwiftUI
import AdmiralCore
import AdmiralTheme
import AdmiralUIResources

@available(iOS 14.0.0, *)
struct ThemeSwitchViewScheme: AppThemeScheme {

    // MARK: - Internal Properties

    var font: AFont
    var backgroundColor: AColor
    var shadowColor: AColor
    var imageColor: AColor

    var themeItemBackgroundColor = ControlParameter<AColor>()
    var themeTextColor = ControlParameter<AColor>()

    // MARK: - Initializer

    init(theme: AppTheme) {
        font = theme.fonts.body1
        backgroundColor = theme.colors.backgroundExtraSurface
        shadowColor = theme.colors.backgroundShadow
        imageColor = theme.colors.elementExtra

        themeTextColor.set(parameter: theme.colors.textStaticWhite, for: .selected)
        themeTextColor.set(parameter: theme.colors.textPrimary, for: .normal)

        themeItemBackgroundColor.set(parameter: theme.colors.backgroundAdditionalOne, for: .normal)
        themeItemBackgroundColor.set(parameter: theme.colors.backgroundAccent, for: .selected)
    }

}
