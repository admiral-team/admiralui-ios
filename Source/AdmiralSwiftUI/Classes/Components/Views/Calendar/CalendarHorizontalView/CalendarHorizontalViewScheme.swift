//
//  CalendarHorizontalViewScheme.swift
//  AdmiralSwiftUI
//
//  Created on 15.09.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources
/**
 CalendarHorizontalViewScheme - the visual scheme of CalendarHorizontalView.
 You can create a by specifying the following parameters in init:
 - CalendarHorizontalViewScheme() - Initialize default CalendarHorizontalViewScheme with default themezation
 # Example to create CalendarHorizontalViewScheme:
 # Code
 ```
 let scheme = CalendarHorizontalViewScheme()
 ```
 */
@available(iOS 14.0.0, *)
public struct CalendarHorizontalViewScheme: AppThemeScheme {

    // MARK: - Public Properties

    /// The picker title color
    public var pickerTitleColor: AColor

    /// Header view scheme
    public var headerViewScheme: CalendarHorizontalHeaderViewScheme

    /// Week view scheme
    public var calendarWeekViewScheme: CalendarWeekViewScheme

    /// Days view scheme.
    public var calendarViewCellColorScheme: CalendarViewCellColorScheme

    // MARK: - Initializer

    public init(theme: AppTheme = .default) {
        pickerTitleColor = theme.colors.textPrimary

        headerViewScheme = CalendarHorizontalHeaderViewScheme(theme: theme)
        calendarWeekViewScheme = CalendarWeekViewScheme(theme: theme)
        calendarViewCellColorScheme = CalendarViewCellColorScheme(theme: theme)
    }

}
