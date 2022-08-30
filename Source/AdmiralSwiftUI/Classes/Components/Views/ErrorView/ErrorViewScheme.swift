//
//  ErrorViewScheme.swift
//  AdmiralSwiftUI
//
//  Created on 02.09.2021.
//

import AdmiralTheme
import AdmiralUIResources
/**
 ErrorViewScheme - the visual scheme of UploadImageView.
 You can create a by specifying the following parameters in init:
 - ErrorViewScheme() - Initialize default ErrorViewScheme with default themezation
 - ErrorViewScheme(
     titleColor: AColor,
     titleFont: AFont
 )
 # Example to create ErrorViewScheme:
 # Code
 ```
 let scheme = ErrorViewScheme()
 ```
 */
public struct ErrorViewScheme: AppThemeScheme {

    // MARK: - Public Properties

    /// The title color of ErrorView
    public var titleColor: AColor

    /// The title font of ErrorView
    public var titleFont: AFont

    // MARK: - Initializer

    public init(theme: AppTheme) {
        titleColor = theme.colors.textSecondary
        titleFont = theme.fonts.subhead4
    }

    public init(
        titleColor: AColor,
        titleFont: AFont
    ) {
        self.titleFont = titleFont
        self.titleColor = titleColor
    }
}

