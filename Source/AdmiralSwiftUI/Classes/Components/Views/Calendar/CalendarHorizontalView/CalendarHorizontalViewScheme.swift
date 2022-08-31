//
//  CalendarHorizontalViewScheme.swift
//  AdmiralSwiftUI
//
//  Created on 15.09.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources
/**
 CalendarHorizontalViewScheme - the visual scheme of CalendarHorizontalView.
 You can create a by specifying the following parameters in init:
 - CalendarHorizontalViewScheme() - Initialize default CalendarHorizontalViewScheme with default themezation
 - CalendarHorizontalViewScheme(
    pickerTitleColor: AColor
 )
 # Example to create CalendarHorizontalViewScheme:
 # Code
 ```
 let scheme = CalendarHorizontalViewScheme()
 ```
 */
@available(iOS 14.0.0, *)
public struct CalendarHorizontalViewScheme: AppThemeScheme {

    // MARK: - Properties

    /// The picker title color of CalendarHorizontalView
    public var pickerTitleColor: AColor

    // MARK: - Initializer

    public init(theme: AppTheme = .default) {
        pickerTitleColor = theme.colors.textPrimary
    }

    public init(pickerTitleColor: AColor) {
        self.pickerTitleColor = pickerTitleColor
    }

}
