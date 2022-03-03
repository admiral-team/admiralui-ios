//
//  CalendarHorizontalViewCellScheme.swift
//  AdmiralUIKit
//
//  Created on 16.11.2021.
//

import AdmiralTheme
import AdmiralUIResources

struct CalendarHorizontalViewCellScheme {
    
    var backgroundColor: AColor
    var calendarViewCellColorScheme: CalendarViewCellColorScheme
    
    init() {
        self.init(theme: AppTheme.default)
    }
    
    init(theme: AppTheme) {
        backgroundColor = theme.colors.backgroundBasic
        calendarViewCellColorScheme = CalendarViewCellColorScheme(theme: theme)
    }
    
}
