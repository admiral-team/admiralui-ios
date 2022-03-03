//
//  ButtonDropDownScheme.swift
//  AdmiralUIKit
//
//  Created on 24.02.2022.
//

import AdmiralTheme
import AdmiralUIResources
import UIKit

struct ButtonDropDownScheme {
    
    var backgroundColor: AColor
    var ghostButtonScheme: HeaderButtonWithArrowScheme
    
    init() {
        self.init(theme: AppTheme.default)
    }
    
    init(theme: AppTheme) {
        backgroundColor = theme.colors.backgroundBasic
        
        ghostButtonScheme = HeaderButtonWithArrowScheme(theme: theme)
    }
}
