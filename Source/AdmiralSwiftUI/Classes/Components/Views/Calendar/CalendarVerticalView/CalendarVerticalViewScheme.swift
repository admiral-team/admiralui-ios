//
//  CalendarViewStyle.swift
//  AdmiralSwiftUI
//
//  Created on 09.06.2021.
//

import SwiftUI
import AdmiralTheme
/**
 CalendarVerticalViewScheme - the visual scheme of CalendarVerticalView .
 You can create a by specifying the following parameters in init:
 - CalendarVerticalViewScheme() - Initialize default CalendarVerticalViewScheme with default themezation
 # Example to create CalendarVerticalViewScheme:
 # Code
 ```
 let scheme = CalendarVerticalViewScheme()
 ```
 */
@available(iOS 14.0.0, *)
public struct CalendarVerticalViewScheme: AppThemeScheme {

    // MARK: - Public Properties

    /// The background color
    public var backgroundColor: AColor

    /// The line background color
    public var lineBackgroundColor: AColor

    /// View scheme for presenting month and year.
    public var monthYearViewScheme: MonthYearViewScheme

    /// Week view scheme
    public var calendarWeekViewScheme: CalendarWeekViewScheme

    /// Cell view scheme.
    public var calendarViewCellColorScheme: CalendarViewCellColorScheme

    // MARK: - Initializer

    public init(theme: AppTheme = .default) {
        backgroundColor = theme.colors.backgroundBasic
        lineBackgroundColor = theme.colors.backgroundAdditionalOne

        monthYearViewScheme = MonthYearViewScheme(theme: theme)
        calendarWeekViewScheme = CalendarWeekViewScheme(theme: theme)
        calendarViewCellColorScheme = CalendarViewCellColorScheme(theme: theme)
    }

}
