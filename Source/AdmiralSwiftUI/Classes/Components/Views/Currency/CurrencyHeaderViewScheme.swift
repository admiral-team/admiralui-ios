//
//  CurrencyHeaderViewScheme.swift
//  AdmiralSwiftUI
//
//  Created on 02.08.2021.
//

import AdmiralTheme
import AdmiralUIResources

public struct CurrencyHeaderViewScheme: AppThemeScheme {
    
    public var textColor: AColor
    public var textFont: AFont
    
    public init(theme: AppTheme) {
        textColor = theme.colors.textSecondary
        textFont = theme.fonts.subhead3
    }
}
