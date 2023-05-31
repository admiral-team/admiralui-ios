//
//  ActionBarViewStyle.swift
//  AdmiralSwiftUI
//
//  Created on 23.06.2021.
//

import AdmiralTheme
/**
 ActionBarViewScheme - the visual scheme of ActionBarView.
 You can create a by specifying the following parameters in init:
 - ActionBarViewScheme() - Initialize default ActionBarViewScheme with default themezation
 # Example to create ActionBarViewScheme:
 # Code
 ```
 let scheme = ActionBarViewScheme()
 ```
 */
@available(iOS 14.0.0, *)
public struct ActionBarViewScheme: AppThemeScheme {

    // MARK: - Public Properties

    /// The background color
    public var backgroundColor = ControlParameter<AColor>()

    /// The action bar control scheme
    public var actionBarConrolScheme: ActionBarControlScheme

    /// The second action bar control scheme
    public var actionBarControlSchemeTwo: ActionBarControlSchemeSecondary

    // MARK: - Initializer

    public init(theme: AppTheme = .default) {
        backgroundColor.set(parameter: theme.colors.backgroundAdditionalOne, for: .normal)
        actionBarConrolScheme = ActionBarControlScheme(theme: theme)
        actionBarControlSchemeTwo = ActionBarControlSchemeSecondary(theme: theme)
    }
}
