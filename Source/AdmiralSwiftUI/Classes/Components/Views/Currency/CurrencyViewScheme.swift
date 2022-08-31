//
//  CurrencyViewStyle.swift
//  AdmiralSwiftUI
//
//  Created on 02.08.2021.
//

import UIKit
import AdmiralTheme
import AdmiralUIResources
/**
 CurrencyViewScheme - the visual scheme of CurrencyView.
 You can create a by specifying the following parameters in init:
 - CurrencyViewScheme() - Initialize default CurrencyViewScheme with default themezation
 - CurrencyViewScheme(
 textColor: AColor,
 textFont: AFont,
 imageTintColor: AColor
 )
 # Example to create CurrencyViewScheme:
 # Code
 ```
 let scheme = CurrencyViewScheme()
 ```
 */
public struct CurrencyViewScheme: AppThemeScheme {

    // MARK: - Properties

    /// The text color of CurrencyView
    public var textColor: AColor

    /// The text font of CurrencyView
    public var textFont: AFont

    /// The image tint color of CurrencyView
    public var imageTintColor: AColor

    // MARK: - Initializer

    public init(theme: AppTheme = .default) {
        textColor = theme.colors.textPrimary
        imageTintColor = theme.colors.elementPrimary
        textFont = theme.fonts.body1
    }

    public init(
        textColor: AColor,
        textFont: AFont,
        imageTintColor: AColor
    ) {
        self.textFont = textFont
        self.textColor = textColor
        self.imageTintColor = imageTintColor
    }
}

