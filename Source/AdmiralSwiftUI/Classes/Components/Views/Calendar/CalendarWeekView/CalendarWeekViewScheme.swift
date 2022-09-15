//
//  CalendarWeekViewStyle.swift
//  AdmiralSwiftUI
//
//  Created on 09.06.2021.
//

import AdmiralTheme
import AdmiralUIResources
/**
 CalendarWeekViewScheme - the visual scheme of CalendarWeekView.
 You can create a by specifying the following parameters in init:
 - CalendarWeekViewScheme() - Initialize default CalendarWeekViewScheme with default themezation
 - CalendarWeekViewScheme(
 titleLabelColor: AColor,
 backgroundColor: AColor,
 titleLabelFont: AFont
 )
 # Example to create CalendarWeekViewScheme:
 # Code
 ```
 let scheme = CalendarWeekViewScheme()
 ```
 */
@available(iOS 14.0.0, *)
public struct CalendarWeekViewScheme: AppThemeScheme {

    // MARK: - Properties

    /// The title label color
    public var titleLabelColor: AColor

    /// The background
    public var backgroundColor: AColor

    /// The title label font
    public var titleLabelFont: AFont

    // MARK: - Initializer

    public init(theme: AppTheme = .default) {
        titleLabelFont = theme.fonts.subhead2

        backgroundColor = theme.colors.backgroundBasic
        titleLabelColor = theme.colors.textSecondary
    }

}
