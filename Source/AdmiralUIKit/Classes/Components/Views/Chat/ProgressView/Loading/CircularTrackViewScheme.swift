//
//  CircleLoadingViewScheme.swift
//  AdmiralUIKit
//
//  Created on 28.12.2021.
//

import AdmiralCore
import AdmiralTheme
import AdmiralUIResources

/**
 CircularTrackViewScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - CircularTrackViewScheme() - Initialize default CircularTrackViewScheme with default themezation
Example to create CircularTrackViewScheme:
Code
 ```
let scheme = CircularTrackViewScheme()
 ```
 */
public struct CircularTrackViewScheme: AppThemeScheme {

    // MARK: - Properties

    /// Progress view scheme.
    public var circleColor = ProgressViewSchemeParameters<AColor>()

    /// Circular color.
    public var color: AColor

    /// Circular stroke color.
    public var strokeColor: AColor

    // MARK: - Initializer

    public init(theme: AppTheme = .default) {
        color = theme.colors.elementStaticWhite
        strokeColor = theme.colors.elementStaticWhite

        circleColor.set(parameter: theme.colors.elementStaticWhite, style: .default)
        circleColor.set(parameter: theme.colors.elementAccent, style: .accent)
    }

}
