//
//  ActionBarViewStyle.swift
//  AdmiralSwiftUI
//
//  Created on 23.06.2021.
//

import AdmiralTheme
import AdmiralUIResources

/// The scheme of ActionBarView.
@available(iOS 14.0.0, *)
public struct ActionBarViewScheme: AppThemeScheme {

    /// The background color of ActionBarView.
    public var backgroundColor = ControlParameter<AColor>()

    /// The scheme of ActionBarControl.
    public var actionBarConrolScheme: ActionBarControlScheme

    /// The scheme of ActionBarControTwol.
    public var actionBarConrolSchemeTwo: ActionBarControlSchemeTwo

    // MARK: - Initializer

    public init(theme: AppTheme) {
        backgroundColor.set(parameter: theme.colors.backgroundAdditionalOne, for: .normal)

        actionBarConrolScheme = ActionBarControlScheme(theme: theme)

        actionBarConrolSchemeTwo = ActionBarControlSchemeTwo(theme: theme)
    }
}
