//
//  ListCellScheme.swift
//  AdmiralUI
//
//  Created on 27.11.2020.
//

import UIKit
import AdmiralTheme
import AdmiralUIResources

struct ListCellScheme {
    
    var backgroundColor = ControlParameter<AColor>()
    
    init() {
        self.init(theme: AppTheme.default)
    }
    
    init(theme: AppTheme) {
        backgroundColor.set(parameter: theme.colors.backgroundSelected, for: .highlighted)
        backgroundColor.set(parameter: theme.colors.backgroundBasic, for: .normal)
    }
}
