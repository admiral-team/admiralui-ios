//
//  ShimmeringViewColorTheme.swift
//  AdmiralUI
//
//  Created on 17.12.2020.
//

import UIKit
import AdmiralTheme
import AdmiralUIResources

struct ShimmeringViewColorScheme {
    
    var backgroundColor: AColor
    
    init() {
        self.init(theme: AppTheme.default)
    }
    
    init(theme: AppTheme) {
        backgroundColor = theme.colors.backgroundAdditionalOne
    }
    
}
