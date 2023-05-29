//
//  ActionBarViewScheme.swift
//  AdmiralUIKit
//
//  Created on 20.01.2022.
//

import AdmiralTheme

/**
 ActionBarViewScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - ActionBarViewScheme() - Initialize default ActionBarViewScheme with default themezation
Example to create ActionBarViewScheme:
Code
 ```
let scheme = ActionBarViewScheme()
 ```
 */
public struct ActionBarViewScheme: AppThemeScheme {

    /// The background color of ActionBarView.
    var backgroundColor: AColor

    /// The scheme of ActioBarControlItem default.
    var actionBarConrolSchemeDefault: ActionItemBarDefaultViewScheme

    /// The sceme of ActionBarControlItem secondary.
    var actionBarControlSchemeSecondary: ActionBarViewSecondaryScheme

    // MARK: - Initializer

    public init() {
        self.init(theme: AppTheme.default)
    }

    public init(theme: AppTheme) {
        backgroundColor = theme.colors.backgroundAdditionalOne
        actionBarConrolSchemeDefault = ActionItemBarDefaultViewScheme(theme: theme)
        actionBarControlSchemeSecondary = ActionBarViewSecondaryScheme(theme: theme)
    }

}
