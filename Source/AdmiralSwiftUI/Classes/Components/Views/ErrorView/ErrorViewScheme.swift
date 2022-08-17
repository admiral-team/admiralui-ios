//
//  ErrorViewScheme.swift
//  AdmiralSwiftUI
//
//  Created on 02.09.2021.
//

import AdmiralTheme
import AdmiralUIResources

public struct ErrorViewScheme: AppThemeScheme {

    // MARK: - Public Properties

    /// The title color of ErrorView
    public var titleColor: AColor

    /// The title font of ErrorView
    public var titleFont: AFont

    // MARK: - Initializer

    public init(theme: AppTheme) {
        titleColor = theme.colors.textSecondary
        titleFont = theme.fonts.subhead4
    }
}
