//
//  CountDownTimerViewScheme.swift
//  AdmiralUIKit
//
//  Created on 28.12.2021.
//

import UIKit
import AdmiralTheme
import AdmiralUIResources

struct CountDownTimerViewScheme {

    var titleTextColor: AColor
    var titleTextFont: AFont
    
    var tintColor: AColor
    
    init() {
        self.init(theme: AppTheme.default)
    }
    
    init(theme: AppTheme) {
        titleTextColor = theme.colors.textAccent
        titleTextFont = theme.fonts.subhead3
        
        tintColor = theme.colors.elementAccent
    }
    
}

