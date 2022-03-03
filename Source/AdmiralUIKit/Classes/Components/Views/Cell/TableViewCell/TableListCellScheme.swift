//
//  TableListCellScheme.swift
//  AdmiralUI
//
//  Created on 24.12.2020.
//

import UIKit
import AdmiralTheme
import AdmiralUIResources

struct TableListCellScheme {
    
    var backgroundColor: AColor
    
    init() {
        self.init(theme: AppTheme.default)
    }
    
    init(theme: AppTheme) {
        backgroundColor = theme.colors.backgroundBasic
    }
    
}
