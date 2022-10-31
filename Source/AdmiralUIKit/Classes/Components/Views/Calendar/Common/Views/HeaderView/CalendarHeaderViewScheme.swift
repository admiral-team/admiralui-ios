//
//  CalendarHeaderViewScheme.swift
//  AdmiralUI
//
//  Created on 01.12.2020.
//

import AdmiralTheme
import AdmiralUIResources

/**
 CalendarHeaderViewScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - CalendarHeaderViewScheme() - Initialize default CalendarHeaderViewScheme with default themezation
Example to create CalendarHeaderViewScheme:
Code
 ```
let scheme = CalendarHeaderViewScheme()
 ```
 */
public struct CalendarHeaderViewScheme: AppThemeScheme {

    /// Title label color.
    public var titleLabelColor: AColor

    /// Background color.
    public var backgroundColor: AColor

    /// Title label font.
    public var titleLabelFont: AFont
    
    public init(theme: AppTheme = .default) {
        titleLabelFont = theme.fonts.subtitle1
        
        backgroundColor = theme.colors.backgroundBasic
        titleLabelColor = theme.colors.textPrimary
    }
    
}
