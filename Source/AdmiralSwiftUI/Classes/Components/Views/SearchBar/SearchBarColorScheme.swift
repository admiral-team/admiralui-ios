//
//  SearchBarColorScheme.swift
//  AdmiralSwiftUI
//
//  Created on 15.06.2021.
//

import AdmiralTheme
import AdmiralUIResources

public struct SearchBarColorScheme: AppThemeScheme {
    
    public var textColor: AColor
    public var placeholderColor: AColor
    public var backgroundColor: AColor
    public var tintColor: AColor
    public var textFont: AFont
    public var placeholderFont: AFont
    public var imageTintColor: AColor
    
    public init(theme: AppTheme) {
        textColor = theme.colors.textPrimary
        placeholderColor = theme.colors.textSecondary
        backgroundColor = theme.colors.backgroundAdditionalOne
        tintColor = theme.colors.elementAccent
        imageTintColor = theme.colors.elementPrimary
        
        textFont = theme.fonts.body2
        placeholderFont = theme.fonts.body2
    }
    
}
