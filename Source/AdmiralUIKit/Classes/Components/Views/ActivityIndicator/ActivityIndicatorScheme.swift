//
//  ActivityIndicatorScheme.swift
//  AdmiralUI
//
//  Created on 25.11.2020.
//

import UIKit
import AdmiralTheme
import AdmiralUIResources

struct ActivityIndicatorScheme {
    var defaultColor: AColor
    var contrastColor: AColor
    
    init() {
        self.init(theme: AppTheme.default)
    }
    
    init(theme: AppTheme) {
        defaultColor = theme.colors.backgroundAccent
        contrastColor = theme.colors.elementStaticWhite
    }
}
