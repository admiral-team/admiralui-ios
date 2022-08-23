//
//  ActivityIndicatorScheme.swift
//  AdmiralSwiftUI
//
//  Created on 02.09.2021.
//

import AdmiralTheme
import AdmiralUIResources

public struct ActivityIndicatorScheme: AppThemeScheme {

    // MARK: - Properties

    /// The background color of ActivityIndicator
    public var backgroundDefaultColor = ControlParameter<AColor>()

    /// The background constant color of ActivityIndicator
    public var backgroundConstrastColor = ControlParameter<AColor>()

    // MARK: - Initializer

    public init(theme: AppTheme) {
        let alpha = theme.colors.disabledAlpha

        backgroundDefaultColor.set(parameter: theme.colors.elementStaticWhite, for: .normal)
        backgroundDefaultColor.set(parameter: theme.colors.elementStaticWhite.withAlpha(alpha), for: .disabled)

        backgroundConstrastColor.set(parameter: theme.colors.elementAccent, for: .normal)
        backgroundConstrastColor.set(parameter: theme.colors.elementAccent.withAlpha(alpha), for: .disabled)
    }

}
