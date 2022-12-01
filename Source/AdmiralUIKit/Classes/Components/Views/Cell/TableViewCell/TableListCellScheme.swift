//
//  TableListCellScheme.swift
//  AdmiralUI
//
//  Created on 24.12.2020.
//

import UIKit
import AdmiralTheme
import AdmiralUIResources

/**
 TableListCellScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - TableListCellScheme() - Initialize default TableListCellScheme with default themezation
Example to create TableListCellScheme:
Code
 ```
let scheme = TableListCellScheme()
 ```
 */
public struct TableListCellScheme: AppThemeScheme {

    /// Background color.
    public var backgroundColor: AColor

    public init(theme: AppTheme = .default) {
        backgroundColor = theme.colors.backgroundBasic
    }
    
}
