//
//  CalendarViewStyle.swift
//  AdmiralSwiftUI
//
//  Created on 09.06.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources
/**
 CalendarVerticalViewScheme - the visual scheme of CalendarVerticalView.
 You can create a by specifying the following parameters in init:
 - CalendarVerticalViewScheme() - Initialize default CalendarVerticalViewScheme with default themezation
 - CalendarVerticalViewScheme(
 backgroundColor: AColor,
 lineBackgroundColor: AColor
 )
 # Example to create CalendarVerticalViewScheme:
 # Code
 ```
 let scheme = CalendarVerticalViewScheme()
 ```
 */
@available(iOS 14.0.0, *)
public struct CalendarVerticalViewScheme: AppThemeScheme {

    // MARK: - Properties

    /// The background color of CalendarVerticalView
    public var backgroundColor: AColor

    /// The line background color of CalendarVerticalView
    public var lineBackgroundColor: AColor

    // MARK: - Initializer

    public init(theme: AppTheme = .default) {
        backgroundColor = theme.colors.backgroundBasic
        lineBackgroundColor = theme.colors.backgroundAdditionalOne
    }

    public init(
        backgroundColor: AColor,
        lineBackgroundColor: AColor
    ) {
        self.backgroundColor = backgroundColor
        self.lineBackgroundColor = lineBackgroundColor
    }

}
