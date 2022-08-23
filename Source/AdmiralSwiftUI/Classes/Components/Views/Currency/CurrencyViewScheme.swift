//
//  CurrencyViewStyle.swift
//  AdmiralSwiftUI
//
//  Created on 02.08.2021.
//

import UIKit
import AdmiralTheme
import AdmiralUIResources

public struct CurrencyViewScheme: AppThemeScheme {

    // MARK: - Properties

    /// The text color of CurrencyView
    public var textColor: AColor

    /// The text font of CurrencyView
    public var textFont: AFont

    /// The image tint color of CurrencyView
    public var imageTintColor: AColor

    // MARK: - Initializer

    public init(theme: AppTheme) {
        textColor = theme.colors.textPrimary
        imageTintColor = theme.colors.elementPrimary
        textFont = theme.fonts.body1
    }
}
