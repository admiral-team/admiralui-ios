//
//  CalendarHorizontalViewScheme.swift
//  AdmiralUIKit
//
//  Created on 28.01.2022.
//

import UIKit
import AdmiralCore
import AdmiralTheme
import AdmiralUIResources

/**
 CalendarHorizontalViewScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - CalendarHorizontalViewScheme() - Initialize default CalendarHorizontalViewScheme with default themezation
Example to create CalendarHorizontalViewScheme:
Code
 ```
let scheme = CalendarHorizontalViewScheme()
 ```
 */
public struct CalendarHorizontalViewScheme: AppThemeScheme {

    /// Background color.
    public var backgroundColor: AColor

    /// Collection view background color.
    public var collectionViewBackgroundColor: AColor

    /// Calendar horizontal view cell scheme.
    public var calendarHorizontalViewCellScheme: CalendarHorizontalViewCellScheme

    /// Calendar header view scheme.
    public var calendarHeaderViewScheme: CalendarHeaderViewScheme

    /// Calendar horizontal header view scheme.
    public var calendarHorizontalHeaderViewScheme: CalendarHorizontalHeaderViewScheme

    /// Month year picker view scheme.
    public var monthYearPickerViewScheme: MonthYearPickerViewScheme

    public init(theme: AppTheme = .default) {
        backgroundColor = theme.colors.backgroundBasic
        collectionViewBackgroundColor = theme.colors.backgroundBasic
        calendarHorizontalViewCellScheme = CalendarHorizontalViewCellScheme(theme: theme)
        calendarHeaderViewScheme = CalendarHeaderViewScheme(theme: theme)
        calendarHorizontalHeaderViewScheme = CalendarHorizontalHeaderViewScheme(theme: theme)
        monthYearPickerViewScheme = MonthYearPickerViewScheme(theme: theme)
    }
    
}

