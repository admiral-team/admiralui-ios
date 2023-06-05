//
//  CurrencyHeaderViewScheme.swift
//  AdmiralUIKit
//
//  Created on 21.02.2022.
//

import AdmiralTheme

/**
 CurrencyHeaderViewScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - CurrencyHeaderViewScheme() - Initialize default CurrencyHeaderViewScheme with default themezation
Example to create CurrencyHeaderViewScheme:
Code
 ```
let scheme = CurrencyHeaderViewScheme()
 ```
 */
public struct CurrencyHeaderViewScheme: AppThemeScheme {

    // MARK: - Internal Properties

    /// Text color.
    public var textColor: AColor

    /// Text font.
    public var textFont: AFont

    /// Background color.
    public var backgroundColor: AColor

    // MARK: - Initializer

    public init(theme: AppTheme = .default) {
        backgroundColor = theme.colors.backgroundBasic
        textColor = theme.colors.textSecondary
        textFont = theme.fonts.subhead3
    }
}
