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
    
    public var textColor: AColor
    public var textFont: AFont
    public var imageTintColor: AColor
    
    public init(theme: AppTheme) {
        textColor = theme.colors.textPrimary
        imageTintColor = theme.colors.elementPrimary
        textFont = theme.fonts.body1
    }
}
