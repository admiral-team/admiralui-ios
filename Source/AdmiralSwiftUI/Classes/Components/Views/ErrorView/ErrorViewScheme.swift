//
//  ErrorViewScheme.swift
//  AdmiralSwiftUI
//
//  Created on 02.09.2021.
//

import AdmiralCore
import AdmiralTheme
import AdmiralUIResources
/**
 ErrorViewScheme - the visual scheme of ErrorView.
 You can create a by specifying the following parameters in init:
 - ErrorViewScheme() - Initialize default ErrorViewScheme with default themezation
 # Example to create ErrorViewScheme:
 # Code
 ```
 let scheme = ErrorViewScheme()
 ```
 */
public struct ErrorViewScheme: AppThemeScheme {

    // MARK: - Public Properties

    /// The title color
    public var titleColor: AColor

    /// The title font
    public var titleFont: AFont

    // MARK: - Initializer

    public init(theme: AppTheme = .default) {
        titleColor = theme.colors.textSecondary
        titleFont = theme.fonts.subhead4
    }

}

