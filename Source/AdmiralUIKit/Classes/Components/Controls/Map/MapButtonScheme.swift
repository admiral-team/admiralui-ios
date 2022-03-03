//
//  MapButtonScheme.swift
//  AdmiralUIKit
//
//  Created on 18.02.2022.
//

import AdmiralTheme
import AdmiralUIResources

struct MapButtonScheme: AppThemeScheme {

    var backgroundColor: AColor
    var selectedBacgroundColor: AColor
    var highlightedBackgroundColor: AColor
    var disabledBacgroundColor: AColor
    let imageTintColor: AColor
    let shadowColor: AColor

    init() {
        self.init(theme: AppTheme.default)
    }

    init(theme: AppTheme) {
        let alpha = theme.colors.disabledAlpha

        backgroundColor = theme.colors.backgroundExtraSurface
        selectedBacgroundColor = theme.colors.backgroundAdditionalOne
        highlightedBackgroundColor = theme.colors.backgroundAdditionalOne
        disabledBacgroundColor = theme.colors.backgroundExtraSurface.withAlpha(alpha)
        imageTintColor = theme.colors.elementPrimary
        shadowColor = theme.colors.backgroundShadow
    }

}
