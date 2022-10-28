//
//  CalendarHorizontalViewCellScheme.swift
//  AdmiralUIKit
//
//  Created on 16.11.2021.
//

import AdmiralTheme
import AdmiralUIResources

/**
 CalendarHorizontalViewCellScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - CalendarHorizontalViewCellScheme() - Initialize default CalendarHorizontalViewCellScheme with default themezation
Example to create CalendarHorizontalViewCellScheme:
Code
 ```
let scheme = CalendarHorizontalViewCellScheme()
 ```
 */
public struct CalendarHorizontalViewCellScheme {

    /// Background color.
    public var backgroundColor: AColor

    /// Calendar view cell color scheme.
    public var calendarViewCellColorScheme: CalendarViewCellColorScheme

    public init(theme: AppTheme = .default) {
        backgroundColor = theme.colors.backgroundBasic
        calendarViewCellColorScheme = CalendarViewCellColorScheme(theme: theme)
    }
    
}
