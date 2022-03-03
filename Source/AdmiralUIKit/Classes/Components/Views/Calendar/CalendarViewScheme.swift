//
//  CalendarViewScheme.swift
//  AdmiralUIKit
//
//  Created on 28.01.2022.
//

import UIKit
import AdmiralTheme
import AdmiralUIResources

struct CalendarViewScheme {
    
    var calendarVerticalViewScheme: CalendarVerticalViewScheme
    var calendarHorizontalViewScheme: CalendarHorizontalViewScheme
    
    init() {
        self.init(theme: AppTheme.default)
    }
    
    init(theme: AppTheme) {
        calendarVerticalViewScheme = CalendarVerticalViewScheme(theme: theme)
        calendarHorizontalViewScheme = CalendarHorizontalViewScheme(theme: theme)
    }
    
}

