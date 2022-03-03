//
//  CircleLoadingViewScheme.swift
//  AdmiralUIKit
//
//  Created on 28.12.2021.
//

import AdmiralTheme
import AdmiralUIResources

public struct CircularTrackViewScheme: AppThemeScheme {

    // MARK: - Properties

    public var circleColor = ProgressViewSchemeParameters<AColor>()
    public var color: AColor
    public var strokeColor: AColor

    // MARK: - Initializer

    init() {
        self.init(theme: AppTheme.default)
    }

    public init(theme: AppTheme) {
        color = theme.colors.elementStaticWhite
        strokeColor = theme.colors.elementStaticWhite

        circleColor.set(parameter: theme.colors.elementStaticWhite, style: .default)
        circleColor.set(parameter: theme.colors.elementAccent, style: .accent)
    }

}
