//
//  CalendarFooterViewColorScheme.swift
//  AdmiralUI
//
//  Created on 01.12.2020.
//

import AdmiralTheme

/**
 CalendarFooterViewColorScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - CalendarFooterViewColorScheme() - Initialize default CalendarFooterViewColorScheme with default themezation
Example to create CalendarFooterViewColorScheme:
Code
 ```
let scheme = CalendarFooterViewColorScheme()
 ```
 */
public struct CalendarFooterViewColorScheme: AppThemeScheme {

    /// Background color.
    public var backgroundColor: AColor

    /// Separator view background color.
    public var separatorViewBackgroundColor: AColor
    
    public init(theme: AppTheme = .default) {
        backgroundColor = theme.colors.backgroundBasic
        separatorViewBackgroundColor = theme.colors.backgroundAdditionalOnePressed
    }
    
}
