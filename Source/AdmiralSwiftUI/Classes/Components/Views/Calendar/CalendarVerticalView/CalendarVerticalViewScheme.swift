//
//  CalendarViewStyle.swift
//  AdmiralSwiftUI
//
//  Created on 09.06.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources

@available(iOS 14.0.0, *)
public struct CalendarVerticalViewScheme: AppThemeScheme {
    
    public var backgroundColor: AColor
    public var lineBackgroundColor: AColor

    /// View scheme for presenting month and year.
    public var monthYearViewScheme: MonthYearViewScheme

    /// Week view scheme
    public var calendarWeekViewScheme: CalendarWeekViewScheme

    /// Cell view scheme.
    public var calendarViewCellColorScheme: CalendarViewCellColorScheme
    
    public init(theme: AppTheme) {
        backgroundColor = theme.colors.backgroundBasic
        lineBackgroundColor = theme.colors.backgroundAdditionalOne

        monthYearViewScheme = MonthYearViewScheme(theme: theme)
        calendarWeekViewScheme = CalendarWeekViewScheme(theme: theme)
        calendarViewCellColorScheme = CalendarViewCellColorScheme(theme: theme)
    }
    
}
