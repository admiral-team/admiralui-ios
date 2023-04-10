//
//  CalendarViewColorScheme.swift
//  AdmiralUI
//
//  Created on 01.12.2020.
//

import UIKit
import AdmiralCore
import AdmiralTheme
import AdmiralUIResources

/**
 CalendarVerticalViewScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - CalendarVerticalViewScheme() - Initialize default CalendarVerticalViewScheme with default themezation
Example to create CalendarVerticalViewScheme:
Code
 ```
let scheme = CalendarVerticalViewScheme()
 ```
 */
public struct CalendarVerticalViewScheme: AppThemeScheme {

    /// Background color.
    public var backgroundColor: AColor

    /// Collection view background color.
    public var collectionViewBackgroundColor: AColor

    /// Calendar view cell color scheme.
    public var calendarViewCellColorScheme: CalendarViewCellColorScheme

    /// Calendar footer view color scheme.
    public var calendarFooterViewColorScheme: CalendarFooterViewColorScheme

    /// Calendar header view scheme.
    public var calendarHeaderViewScheme: CalendarHeaderViewScheme
    
    public init(theme: AppTheme = .default) {
        backgroundColor = theme.colors.backgroundBasic
        collectionViewBackgroundColor = theme.colors.backgroundBasic
        calendarViewCellColorScheme = CalendarViewCellColorScheme(theme: theme)
        calendarFooterViewColorScheme = CalendarFooterViewColorScheme(theme: theme)
        calendarHeaderViewScheme = CalendarHeaderViewScheme(theme: theme)
    }
    
}
