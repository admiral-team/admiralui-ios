//
//  CurrencyHeaderViewScheme.swift
//  AdmiralSwiftUI
//
//  Created on 02.08.2021.
//

import AdmiralTheme
import AdmiralUIResources

public struct CurrencyHeaderViewScheme: AppThemeScheme {

    // MARK: - Properties

    /// The text color of CurrencyHeaderView
    public var textColor: AColor

    /// The text font of CurrencyHeaderView
    public var textFont: AFont

    // MARK: - Initializer

    public init(theme: AppTheme) {
        textColor = theme.colors.textSecondary
        textFont = theme.fonts.subhead3
    }
}
