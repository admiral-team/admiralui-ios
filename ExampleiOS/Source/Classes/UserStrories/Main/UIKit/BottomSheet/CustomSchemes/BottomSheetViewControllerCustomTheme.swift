//
//  BottomSheetViewControllerCustomTheme.swift
//  ExampleiOS
//
//  Created on 22.04.2021.
//

import AdmiralCore
import AdmiralTheme
import AdmiralUIResources

struct BottomSheetViewControllerCustomTheme {
    var descriptionLabelFont: AFont

    var backgroundColor: AColor
    var descriptionLabelTextColor: AColor
    
    init() {
        self.init(theme: AppTheme.default)
    }
    
    init(theme: AppTheme) {
        descriptionLabelFont = theme.fonts.body2
        descriptionLabelTextColor = theme.colors.textPrimary
        backgroundColor = theme.colors.backgroundBasic
    }
  
}
