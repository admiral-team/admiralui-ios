//
//  ActionCellViewScheme.swift
//  AdmiralUI
//
//  Created on 30.11.2020.
//

import UIKit
import AdmiralTheme
import AdmiralUIResources

struct ActionCellViewScheme {
    var backgroundColor = ControlParameter<AColor>()
    
    init() {
        self.init(theme: AppTheme.default)
    }
    
    init(theme: AppTheme) {
        backgroundColor.set(parameter: theme.colors.backgroundAdditionalOne, for: .normal)
    }
}
