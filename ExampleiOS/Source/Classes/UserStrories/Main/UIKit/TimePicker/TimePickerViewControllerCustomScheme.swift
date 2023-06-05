//
//  TimePickerViewControllerCustomScheme.swift
//  ExampleiOS
//
//  Created on 23.04.2021.
//

import AdmiralTheme
import UIKit

struct TimePickerViewControllerCustomScheme {
    
    var titleLabelFont: AFont
    var titleLabelTextColor: AColor
    
    init() {
        self.init(theme: AppTheme.default)
    }
    
    init(theme: AppTheme) {
        titleLabelFont = theme.fonts.body1
        titleLabelTextColor = theme.colors.textPrimary
    }

}
