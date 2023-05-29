//
//  ListCellScheme.swift
//  AdmiralUI
//
//  Created on 27.11.2020.
//

import UIKit
import AdmiralTheme

/**
 ListCellScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - ListCellScheme() - Initialize default ListCellScheme with default themezation
Example to create ListCellScheme:
Code
 ```
let scheme = ListCellScheme()
 ```
 */
public struct ListCellScheme {
    
    public var backgroundColor = ControlParameter<AColor>()
    
    public init(theme: AppTheme = .default) {
        backgroundColor.set(parameter: theme.colors.backgroundSelected, for: .highlighted)
        backgroundColor.set(parameter: theme.colors.backgroundBasic, for: .normal)
    }
}
