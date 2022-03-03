//
//  CalendarHorizontalViewScheme.swift
//  AdmiralUIKit
//
//  Created on 28.01.2022.
//

import UIKit
import AdmiralTheme
import AdmiralUIResources

struct CalendarHorizontalViewScheme {
    
    var backgroundColor: AColor
    var collectionViewBackgroundColor: AColor
    var calendarHorizontalViewCellScheme: CalendarHorizontalViewCellScheme
    var calendarHeaderViewScheme: CalendarHeaderViewScheme
    var calendarHorizontalHeaderViewScheme: CalendarHorizontalHeaderViewScheme
    var monthYearPickerViewScheme: MonthYearPickerViewScheme
    
    init() {
        self.init(theme: AppTheme.default)
    }
    
    init(theme: AppTheme) {
        backgroundColor = theme.colors.backgroundBasic
        collectionViewBackgroundColor = theme.colors.backgroundBasic
        calendarHorizontalViewCellScheme = CalendarHorizontalViewCellScheme(theme: theme)
        calendarHeaderViewScheme = CalendarHeaderViewScheme(theme: theme)
        calendarHorizontalHeaderViewScheme = CalendarHorizontalHeaderViewScheme(theme: theme)
        monthYearPickerViewScheme = MonthYearPickerViewScheme(theme: theme)
    }
    
}

