//
//  ChatButtonCustomScheme.swift
//  AdmiralUIKit
//
//  Created on 25.11.2021.
//

import AdmiralTheme
import AdmiralUIResources

public struct ChatButtonCustomScheme {

    var normalTextColor: AColor
    var disabledTextColor: AColor
    var backgroundLayerColor: AColor
    var backgroundNormalColor: AColor
    var backgroundHightlightedColor: AColor
    var backgroundDisabledColor: AColor

    var titleLabelFont: AFont

    init() {
        self.init(theme: AppTheme.default)
    }

    init(theme: AppTheme) {
        let alpha = theme.colors.disabledAlpha

        titleLabelFont = theme.fonts.body1

        normalTextColor = theme.colors.textStaticWhite
        disabledTextColor = theme.colors.textStaticWhite.withAlpha(alpha)
        
        backgroundLayerColor = theme.colors.backgroundBasic
        backgroundNormalColor = theme.colors.backgroundAccent
        backgroundHightlightedColor = theme.colors.backgroundAccentPressed
        backgroundDisabledColor = theme.colors.backgroundAccent.withAlpha(alpha)
    }

}
