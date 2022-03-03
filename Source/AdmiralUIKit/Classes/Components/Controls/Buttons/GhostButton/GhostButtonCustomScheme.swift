//
//  GhostButtonCustomScheme.swift
//  AdmiralUIKit
//
//  Created on 22.04.2021.
//

import AdmiralTheme
import AdmiralUIResources

public struct GhostButtonCustomScheme {
    
    var normalTextColor: AColor
    var highlightedTextColor: AColor
    var disabledTextColor: AColor
    
    var titleLabelFont: AFont
    var activityIndicatorScheme: ActivityIndicatorScheme

    init() {
        self.init(theme: AppTheme.default)
    }
    
    init(theme: AppTheme) {
        let alpha = theme.colors.disabledAlpha

        titleLabelFont = theme.fonts.body1
        normalTextColor = theme.colors.textAccent
        highlightedTextColor = theme.colors.textAccentPressed
        disabledTextColor = theme.colors.textAccent.withAlpha(alpha)

        activityIndicatorScheme = ActivityIndicatorScheme(theme: theme)
    }
    
}
