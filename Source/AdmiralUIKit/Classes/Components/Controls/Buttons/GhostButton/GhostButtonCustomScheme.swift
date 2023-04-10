//
//  GhostButtonCustomScheme.swift
//  AdmiralUIKit
//
//  Created on 22.04.2021.
//

import AdmiralCore
import AdmiralTheme
import AdmiralUIResources

/**
 GhostButtonCustomScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - GhostButtonCustomScheme() - Initialize default GhostButtonCustomScheme with default themezation
Example to create GhostButtonCustomScheme:
Code
 ```
let scheme = GhostButtonCustomScheme()
 ```
 */
public struct GhostButtonCustomScheme: AppThemeScheme {

    /// Normal text color.
    public var normalTextColor: AColor

    /// Highlighted text color.
    public var highlightedTextColor: AColor

    /// Disabled text color.
    public var disabledTextColor: AColor

    /// Title label font.
    public var titleLabelFont: AFont

    /// Activity indicator scheme.
    public var activityIndicatorScheme: ActivityIndicatorScheme
    
    public init(theme: AppTheme = .default) {
        let alpha = theme.colors.disabledAlpha

        titleLabelFont = theme.fonts.body1
        normalTextColor = theme.colors.textAccent
        highlightedTextColor = theme.colors.textAccentPressed
        disabledTextColor = theme.colors.textAccent.withAlpha(alpha)

        activityIndicatorScheme = ActivityIndicatorScheme(theme: theme)
    }
    
}
