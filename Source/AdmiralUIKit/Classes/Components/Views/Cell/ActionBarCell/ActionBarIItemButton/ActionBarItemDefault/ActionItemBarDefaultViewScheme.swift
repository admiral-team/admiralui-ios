//
//  ActionBarButtonScheme.swift
//  AdmiralUI
//
//  Created on 02.12.2020.
//

import UIKit
import AdmiralTheme
import AdmiralUIResources

/// The scheme of ActionBarControl.
struct ActionItemBarDefaultViewScheme {

    // MARK: - Public properties

    /// The backgroundColor of ActionBarControl.
    var backgroundColor = ControlParameter<AColor>()

    /// The scheme of ActionItemBarDefaultControl.
    var controlScheme: ActionItemBarDefaultControlScheme

    // MARK: - Initializer

    init() {
        self.init(theme: AppTheme.default)
    }

    init(theme: AppTheme) {
        controlScheme = ActionItemBarDefaultControlScheme(theme: theme)
        backgroundColor.set(parameter: theme.colors.backgroundAdditionalOne, for: .normal)
    }
}
