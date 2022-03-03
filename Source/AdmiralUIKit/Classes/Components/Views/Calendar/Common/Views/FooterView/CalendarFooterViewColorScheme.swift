//
//  CalendarFooterViewColorScheme.swift
//  AdmiralUI
//
//  Created on 01.12.2020.
//

import AdmiralTheme
import AdmiralUIResources

struct CalendarFooterViewColorScheme {
    var backgroundColor: AColor
    var separatorViewBackgroundColor: AColor
    
    init() {
        self.init(theme: AppTheme.default)
    }
    
    init(theme: AppTheme) {
        backgroundColor = theme.colors.backgroundBasic
        separatorViewBackgroundColor = theme.colors.backgroundAdditionalOnePressed
    }
    
}
