//
//  MonthYearPickerViewScheme.swift
//  AdmiralUIKit
//
//  Created on 18.11.2021.
//

import AdmiralTheme
import AdmiralUIResources

struct MonthYearPickerViewScheme {
    
    var textColor: AColor
    
    init() {
        self.init(theme: AppTheme.default)
    }
    
    init(theme: AppTheme) {
        textColor = theme.colors.textPrimary
    }
    
}
