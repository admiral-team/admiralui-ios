//
//  ActionCellViewScheme.swift
//  AdmiralUI
//
//  Created on 30.11.2020.
//

import UIKit
import AdmiralTheme

/**
 ActionCellViewScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - ActionCellViewScheme() - Initialize default ActionCellViewScheme with default themezation
Example to create ActionCellViewScheme:
Code
 ```
let scheme = ActionCellViewScheme()
 ```
 */
public struct ActionCellViewScheme: AppThemeScheme {

    /// Background color.
    public var backgroundColor = ControlParameter<AColor>()

    public init(theme: AppTheme = .default) {
        backgroundColor.set(parameter: theme.colors.backgroundAdditionalOne, for: .normal)
    }

}
