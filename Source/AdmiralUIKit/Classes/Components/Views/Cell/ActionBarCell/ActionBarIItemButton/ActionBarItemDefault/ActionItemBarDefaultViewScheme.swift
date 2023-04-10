//
//  ActionBarButtonScheme.swift
//  AdmiralUI
//
//  Created on 02.12.2020.
//

import UIKit
import AdmiralCore
import AdmiralTheme
import AdmiralUIResources

/**
 ActionItemBarDefaultViewScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - ActionItemBarDefaultViewScheme() - Initialize default ActionItemBarDefaultViewScheme with default themezation
Example to create ActionItemBarDefaultViewScheme:
Code
 ```
let scheme = ActionItemBarDefaultViewScheme()
 ```
 */
public struct ActionItemBarDefaultViewScheme: AppThemeScheme {

    // MARK: - Public properties

    /// The backgroundColor of ActionBarControl.
    public var backgroundColor = ControlParameter<AColor>()

    /// The scheme of ActionItemBarDefaultControl.
    public var controlScheme: ActionItemBarDefaultControlScheme

    // MARK: - Initializer

    public init(theme: AppTheme = .default) {
        controlScheme = ActionItemBarDefaultControlScheme(theme: theme)
        backgroundColor.set(parameter: theme.colors.backgroundAdditionalOne, for: .normal)
    }
}
