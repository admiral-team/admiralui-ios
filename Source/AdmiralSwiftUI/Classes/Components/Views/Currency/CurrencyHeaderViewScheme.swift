//
//  CurrencyHeaderViewScheme.swift
//  AdmiralSwiftUI
//
//  Created on 02.08.2021.
//

import AdmiralCore
import AdmiralTheme
import AdmiralUIResources
/**
 CurrencyHeaderViewScheme - the visual scheme of CurrencyHeaderView.
 You can create a by specifying the following parameters in init:
 - CalendarWeekViewScheme() - Initialize default CalendarWeekViewScheme with default themezation
 # Example to create CalendarWeekViewScheme:
 # Code
 ```
 let scheme = CalendarWeekViewScheme()
 ```
 */
public struct CurrencyHeaderViewScheme: AppThemeScheme {

    // MARK: - Properties

    /// The text color
    public var textColor: AColor

    /// The text font
    public var textFont: AFont

    // MARK: - Initializer

    public init(theme: AppTheme = .default) {
        textColor = theme.colors.textSecondary
        textFont = theme.fonts.subhead3
    }

}

