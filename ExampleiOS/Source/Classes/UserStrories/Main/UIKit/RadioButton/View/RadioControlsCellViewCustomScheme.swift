//
//  RadioControlsCellViewCustomScheme.swift
//  ExampleiOS
//
//  Created on 23.04.2021.
//

import AdmiralCore
import AdmiralTheme
import AdmiralUIResources
import UIKit

struct RadioControlsCellViewCustomScheme {
    
    var titleLabelFont: AFont
    var titleLabelTextColor: AColor
    var backgroundColor: AColor
    
    init() {
        self.init(theme: AppTheme.default)
    }
    
    init(theme: AppTheme) {
        titleLabelFont = theme.fonts.headline
        titleLabelTextColor = theme.colors.textSecondary
        backgroundColor = theme.colors.backgroundBasic
    }

}
