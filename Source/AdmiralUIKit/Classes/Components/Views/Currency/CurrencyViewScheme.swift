//
//  CurrencyViewScheme.swift
//  AdmiralUIKit
//
//  Created on 21.02.2022.
//

import AdmiralTheme
import AdmiralUIResources

/**
 CurrencyViewScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - CurrencyViewScheme() - Initialize default CurrencyViewScheme with default themezation
Example to create CurrencyViewScheme:
Code
 ```
let scheme = CurrencyViewScheme()
 ```
 */
public struct CurrencyViewScheme: AppThemeScheme {

    // MARK: - Internal properties

    /// Text color.
    public var textColor: AColor

    /// Text font.
    public var textFont: AFont

    /// Image tint color.
    public var imageTintColor: AColor

    /// Background color.
    public var backgroundColor: AColor

    // MARK: - Initializer

    public init(theme: AppTheme = .default) {
        backgroundColor = theme.colors.backgroundBasic
        textColor = theme.colors.textPrimary
        imageTintColor = theme.colors.elementPrimary
        textFont = theme.fonts.body1
    }
}

