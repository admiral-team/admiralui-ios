//
//  SwitchListViewScheme.swift
//  AdmiralUI
//
//  Created on 27.11.2020.
//

import UIKit
import AdmiralCore
import AdmiralTheme
import AdmiralUIResources

/**
 SwitchListViewScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - SwitchListViewScheme() - Initialize default SwitchListViewScheme with default themezation
Example to create SwitchListViewScheme:
Code
 ```
let scheme = SwitchListViewScheme()
 ```
 */
public struct SwitchListViewScheme: AppThemeScheme {

    /// Background color.
    public var backgroundColor = ControlParameter<AColor>()
    
    public init(theme: AppTheme = .default) {
        backgroundColor.set(parameter: theme.colors.backgroundSelected, for: .highlighted)
        backgroundColor.set(parameter: theme.colors.backgroundBasic, for: .normal)
    }
}
