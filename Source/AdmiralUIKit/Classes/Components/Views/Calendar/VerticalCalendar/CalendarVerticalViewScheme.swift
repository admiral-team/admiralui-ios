//
//  CalendarViewColorScheme.swift
//  AdmiralUI
//
//  Created on 01.12.2020.
//

import UIKit
import AdmiralTheme
import AdmiralUIResources

struct CalendarVerticalViewScheme {
    
    var backgroundColor: AColor
    var collectionViewBackgroundColor: AColor
    var calendarViewCellColorScheme: CalendarViewCellColorScheme
    var calendarFooterViewColorScheme: CalendarFooterViewColorScheme
    var calendarHeaderViewScheme: CalendarHeaderViewScheme
    
    init() {
        self.init(theme: AppTheme.default)
    }
    
    init(theme: AppTheme) {
        backgroundColor = theme.colors.backgroundBasic
        collectionViewBackgroundColor = theme.colors.backgroundBasic
        calendarViewCellColorScheme = CalendarViewCellColorScheme(theme: theme)
        calendarFooterViewColorScheme = CalendarFooterViewColorScheme(theme: theme)
        calendarHeaderViewScheme = CalendarHeaderViewScheme(theme: theme)
    }
    
}
