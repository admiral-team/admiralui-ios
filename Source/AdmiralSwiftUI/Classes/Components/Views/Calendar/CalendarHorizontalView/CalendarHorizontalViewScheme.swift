//
//  CalendarHorizontalViewScheme.swift
//  AdmiralSwiftUI
//
//  Created on 15.09.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources

@available(iOS 14.0.0, *)
public struct CalendarHorizontalViewScheme: AppThemeScheme {
    
    public var pickerTitleColor: AColor

    /// Header view scheme
    public var headerViewScheme: CalendarHorizontalHeaderViewScheme

    /// Week view scheme
    public var calendarWeekViewScheme: CalendarWeekViewScheme

    /// Days view scheme.
    public var calendarViewCellColorScheme: CalendarViewCellColorScheme
    
    public init(theme: AppTheme) {
        pickerTitleColor = theme.colors.textPrimary

        headerViewScheme = CalendarHorizontalHeaderViewScheme(theme: theme)
        calendarWeekViewScheme = CalendarWeekViewScheme(theme: theme)
        calendarViewCellColorScheme = CalendarViewCellColorScheme(theme: theme)
    }
    
}
