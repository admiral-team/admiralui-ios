//
//  SearchBarColorScheme.swift
//  AdmiralSwiftUI
//
//  Created on 15.06.2021.
//

import AdmiralTheme
/**
 SearchBarColorScheme - the visual scheme .
 You can create a by specifying the following parameters in init:
 - SearchBarColorScheme() - Initialize default SearchBarColorScheme with default themezation
 # Example to create SearchBarColorScheme:
 # Code
 ```
 let scheme = SearchBarColorScheme()
 ```
 */
public struct SearchBarColorScheme: AppThemeScheme {

    // MARK: - Public Properties

    /// The text color
    public var textColor: AColor

    /// The placeholder color
    public var placeholderColor: AColor

    /// The tbackgroundext color
    public var backgroundColor: AColor

    /// The tint color
    public var tintColor: AColor

    /// The text font
    public var textFont: AFont

    /// The placeholder font
    public var placeholderFont: AFont

    /// The image tint color
    public var imageTintColor: AColor

    // MARK: - Initializer

    public init(theme: AppTheme = .default) {
        textColor = theme.colors.textPrimary
        placeholderColor = theme.colors.textSecondary
        backgroundColor = theme.colors.backgroundAdditionalOne
        tintColor = theme.colors.elementAccent
        imageTintColor = theme.colors.elementPrimary

        textFont = theme.fonts.body2
        placeholderFont = theme.fonts.body2
    }

}

