//
//  CalendarHorizontalHeaderViewScheme.swift
//  AdmiralUIKit
//
//  Created on 10.11.2021.
//

import AdmiralTheme
import AdmiralUIResources

/**
 CalendarHorizontalHeaderViewScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - CalendarHorizontalHeaderViewScheme() - Initialize default CalendarHorizontalHeaderViewScheme with default themezation
Example to create CalendarHorizontalHeaderViewScheme:
Code
 ```
let scheme = CalendarHorizontalHeaderViewScheme()
 ```
 */
public struct CalendarHorizontalHeaderViewScheme: AppThemeScheme {

    /// Background color.
    public var backgroundColor: AColor

    /// Button with arrow scheme.
    public var buttonWithArrowScheme: ButtonWithArrowScheme

    /// Ghost button custom scheme.
    public var ghostButtonCustomScheme: GhostButtonCustomScheme
    
    public init(theme: AppTheme = .default) {
        backgroundColor = theme.colors.backgroundBasic
        buttonWithArrowScheme = ButtonWithArrowScheme(theme: theme)
        ghostButtonCustomScheme = GhostButtonCustomScheme(theme: theme)
    }
            
}
