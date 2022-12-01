//
//  ErrorViewScheme.swift
//  AdmiralUIKit
//
//  Created on 16.02.2022.
//

import AdmiralTheme
import AdmiralUIResources

/**
 ErrorViewScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - ErrorViewScheme() - Initialize default ErrorViewScheme with default themezation
Example to create ErrorViewScheme:
Code
 ```
let scheme = ErrorViewScheme()
 ```
 */
public struct ErrorViewScheme: AppThemeScheme {

    /// Title color.
    public var titleColor: AColor

    /// Title font.
    public var titleFont: AFont

    /// Background color.
    public var backgroundColor: AColor

    public var ghostButtonScheme: GhostButtonCustomScheme

    public init(theme: AppTheme = .default) {
        titleColor = theme.colors.textSecondary
        titleFont = theme.fonts.subhead4
        backgroundColor = theme.colors.backgroundBasic

        ghostButtonScheme = GhostButtonCustomScheme(theme: theme)
    }
}
