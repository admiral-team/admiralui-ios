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
 CurrencyViewScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - CurrencyViewScheme() - Initialize default CurrencyViewScheme with default themezation
 # Example to create CurrencyViewScheme:
 # Code
 ```
 let scheme = CurrencyViewScheme()
 ```
 */
public struct CurrencyViewScheme: AppThemeScheme {

    // MARK: - Properties

    /// The text color
    public var textColor: AColor

    /// The text font
    public var textFont: AFont

    /// The image tint color
    public var imageTintColor: AColor

    // MARK: - Initializer

    public init(theme: AppTheme = .default) {
        textColor = theme.colors.textPrimary
        imageTintColor = theme.colors.elementPrimary
        textFont = theme.fonts.body1
    }

}

