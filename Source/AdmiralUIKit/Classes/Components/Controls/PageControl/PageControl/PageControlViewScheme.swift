//
//  PageControlViewScheme.swift
//  AdmiralUI
//
//  Created on 23.12.2020.
//

import UIKit
import AdmiralTheme
import AdmiralUIResources

struct PageControlViewScheme {
            
    var backgroundColor = ControlParameter<AColor>()
    
    init() {
        self.init(theme: AppTheme.default)
    }
    
    init(theme: AppTheme) {
        backgroundColor.set(parameter: theme.colors.textSecondary, for: .normal)
        backgroundColor.set(parameter: theme.colors.textPrimary, for: .selected)
    }
    
}
