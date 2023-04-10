//
//  RadioButtonListViewScheme.swift
//  AdmiralUI
//
//  Created on 27.11.2020.
//

import AdmiralCore
import AdmiralTheme
import AdmiralUIResources

/**
 RadioButtonListViewScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - RadioButtonListViewScheme() - Initialize default RadioButtonListViewScheme with default themezation
Example to create RadioButtonListViewScheme:
Code
 ```
let scheme = RadioButtonListViewScheme()
 ```
 */
public struct RadioButtonListViewScheme: AppThemeScheme {

    /// Background color.
    public var backgroundColor = ControlParameter<AColor>()

    /// Tadio button view tint color.
    public var radioButtonViewTintColor = ControlParameter<AColor>()

    /// Radio button scheme.
    public var radioButtonScheme = CheckTextControlScheme()
    
    public init(theme: AppTheme = .default) {
        let alpha = theme.colors.disabledAlpha

        backgroundColor.set(parameter: theme.colors.backgroundSelected, for: .highlighted)
        backgroundColor.set(parameter: theme.colors.backgroundBasic, for: .normal)

        radioButtonViewTintColor.set(parameter: theme.colors.elementAccent.withAlpha(alpha), for: .disabled)
        radioButtonViewTintColor.set(parameter: theme.colors.elementAccent, for: .normal)
        
        radioButtonScheme = CheckTextControlScheme(theme: theme)
    }
}
