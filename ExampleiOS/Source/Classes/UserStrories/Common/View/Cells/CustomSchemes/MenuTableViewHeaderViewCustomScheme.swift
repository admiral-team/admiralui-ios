//
//  MenuTableViewHeaderViewCustomScheme.swift
//  ExampleiOS
//
//  Created on 23.04.2021.
//

import AdmiralCore
import AdmiralTheme
import AdmiralUIResources
import UIKit

struct MenuTableViewHeaderViewCustomScheme {
    
    var titleLabelFont: AFont
    var titleLabelTextColor: AColor
    
    init() {
        self.init(theme: AppTheme.default)
    }
    
    init(theme: AppTheme) {
        titleLabelFont = theme.fonts.headline
        titleLabelTextColor = theme.colors.textSecondary
    }

}
