//
//  SearchBarColorScheme.swift
//  AdmiralUI
//
//  Created on 21.02.2021.
//

import AdmiralCore
import AdmiralTheme
import AdmiralUIResources

/**
 SearchBarColorScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - SearchBarColorScheme() - Initialize default SearchBarColorScheme with default themezation
Example to create SearchBarColorScheme:
Code
 ```
let scheme = SearchBarColorScheme()
 ```
 */
public struct SearchBarColorScheme: AppThemeScheme {

    /// Text color.
    public var textColor: AColor

    /// Placeholder color.
    public var placeholderColor: AColor

    /// Background color.
    public var backgroundColor: AColor

    /// Tint color.
    public var tintColor: AColor

    /// Text font.
    public var textFont: AFont

    /// Placeholder font.
    public var placeholderFont: AFont
    
    public init(theme: AppTheme = .default) {
        textColor = theme.colors.textPrimary
        placeholderColor = theme.colors.textSecondary
        backgroundColor = theme.colors.backgroundAdditionalOne
        tintColor = theme.colors.elementAccent
        
        textFont = theme.fonts.body2
        placeholderFont = theme.fonts.body2
    }
}
