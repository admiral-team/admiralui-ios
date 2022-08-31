//
//  SearchBarColorScheme.swift
//  AdmiralSwiftUI
//
//  Created on 15.06.2021.
//

import AdmiralTheme
import AdmiralUIResources
/**
 SearchBarColorScheme - the visual scheme of SearchBar.
 You can create a by specifying the following parameters in init:
 - SearchBarColorScheme() - Initialize default SearchBarColorScheme with default themezation
 - SearchBarColorScheme(
 textColor: AColor,
 placeholderColor: AColor,
 backgroundColor: AColor,
 tintColor: AColor,
 textFont: AFont,
 placeholderFont: AFont,
 imageTintColor: AColor
 )
 # Example to create SearchBarColorScheme:
 # Code
 ```
 let scheme = SearchBarColorScheme()
 ```
 */
public struct SearchBarColorScheme: AppThemeScheme {

    // MARK: - Properties

    /// The text color of SearchBar
    public var textColor: AColor

    /// The placeholder color of SearchBar
    public var placeholderColor: AColor

    /// The tbackgroundext color of SearchBar
    public var backgroundColor: AColor

    /// The tint color of SearchBar
    public var tintColor: AColor

    /// The text font of SearchBar
    public var textFont: AFont

    /// The placeholder font of SearchBar
    public var placeholderFont: AFont

    /// The image tint color of SearchBar
    public var imageTintColor: AColor

    // MARK: - Initializer

    public init(theme: AppTheme) {
        textColor = theme.colors.textPrimary
        placeholderColor = theme.colors.textSecondary
        backgroundColor = theme.colors.backgroundAdditionalOne
        tintColor = theme.colors.elementAccent
        imageTintColor = theme.colors.elementPrimary

        textFont = theme.fonts.body2
        placeholderFont = theme.fonts.body2
    }

    public init(
        textColor: AColor,
        placeholderColor: AColor,
        backgroundColor: AColor,
        tintColor: AColor,
        textFont: AFont,
        placeholderFont: AFont,
        imageTintColor: AColor
    ) {
        self.textColor = textColor
        self.placeholderColor = placeholderColor
        self.backgroundColor = backgroundColor
        self.tintColor = tintColor
        self.imageTintColor = imageTintColor

        self.textFont = textFont
        self.placeholderFont = placeholderFont
    }

}

