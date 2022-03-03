//
//  ErrorViewScheme.swift
//  AdmiralUIKit
//
//  Created on 16.02.2022.
//

import AdmiralTheme
import AdmiralUIResources

public struct ErrorViewScheme: AppThemeScheme {

    public var titleColor: AColor
    public var titleFont: AFont
    public var backgroundColor: AColor

    public var ghostButtonScheme: GhostButtonCustomScheme

    public init() {
        self.init(theme: AppTheme.default)
    }

    public init(theme: AppTheme) {
        titleColor = theme.colors.textSecondary
        titleFont = theme.fonts.subhead4
        backgroundColor = theme.colors.backgroundBasic

        ghostButtonScheme = GhostButtonCustomScheme(theme: theme)
    }
}
