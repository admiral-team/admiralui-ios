//
//  CheckBoxListViewScheme.swift
//  AdmiralUI
//
//  Created on 27.11.2020.
//

import UIKit
import AdmiralCore
import AdmiralTheme
import AdmiralUIResources

/**
 CheckBoxListViewScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - CheckBoxListViewScheme() - Initialize default CheckBoxListViewScheme with default themezation
Example to create CheckBoxListViewScheme:
Code
 ```
let scheme = CheckBoxListViewScheme()
 ```
 */
public struct CheckBoxListViewScheme: AppThemeScheme {

    /// Background color.
    public var backgroundColor = ControlParameter<AColor>()

    /// Check box tint color.
    public var checkBoxTintColor = ControlParameter<AColor>()

    /// Check box scheme.
    public var checkBoxScheme = CheckTextControlScheme()

    public init(theme: AppTheme = .default) {
        let alpha = theme.colors.disabledAlpha

        backgroundColor.set(parameter: theme.colors.backgroundSelected, for: .highlighted)
        backgroundColor.set(parameter: theme.colors.backgroundBasic, for: .normal)

        checkBoxTintColor.set(parameter: theme.colors.elementAccent, for: .normal)
        checkBoxTintColor.set(parameter: theme.colors.elementAccent.withAlpha(alpha), for: .disabled)
        
        checkBoxScheme = CheckTextControlScheme(theme: theme)
    }
}
