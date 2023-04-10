//
//  ControlCellViewCustomScheme.swift
//  ExampleiOS
//
//  Created by on 23.11.2022.
//  
//

import AdmiralCore
import AdmiralTheme
import AdmiralUIResources
import UIKit

struct ControlCellViewCustomScheme {
    
    /// Title label font.
    var titleLabelFont: AFont
    
    // Title label color.
    var titleLabelTextColor: AColor
    
    init() {
        self.init(theme: AppTheme.default)
    }
    
    init(theme: AppTheme) {
        titleLabelFont = theme.fonts.headline
        titleLabelTextColor = theme.colors.textSecondary
    }

}
