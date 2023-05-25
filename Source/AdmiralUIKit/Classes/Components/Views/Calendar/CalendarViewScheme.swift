//
//  CalendarViewScheme.swift
//  AdmiralUIKit
//
//  Created on 28.01.2022.
//

import UIKit
import AdmiralTheme

/**
 CalendarViewScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - CalendarViewScheme() - Initialize default CalendarViewScheme with default themezation
Example to create CalendarViewScheme:
Code
 ```
let scheme = CalendarViewScheme()
 ```
 */
public struct CalendarViewScheme: AppThemeScheme {

    /// Calendar vertical view scheme.
    public var calendarVerticalViewScheme: CalendarVerticalViewScheme

    /// Calendar horizontal view scheme.
    public var calendarHorizontalViewScheme: CalendarHorizontalViewScheme
    
    public init(theme: AppTheme = .default) {
        calendarVerticalViewScheme = CalendarVerticalViewScheme(theme: theme)
        calendarHorizontalViewScheme = CalendarHorizontalViewScheme(theme: theme)
    }
    
}

