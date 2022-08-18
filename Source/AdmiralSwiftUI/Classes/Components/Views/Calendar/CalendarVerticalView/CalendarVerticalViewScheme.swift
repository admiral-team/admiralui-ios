//
//  CalendarViewStyle.swift
//  AdmiralSwiftUI
//
//  Created on 09.06.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources

@available(iOS 14.0.0, *)
public struct CalendarVerticalViewScheme: AppThemeScheme {

    // MARK: - Properties

    /// The background color of CalendarVerticalView
    public var backgroundColor: AColor

    /// The line background color of CalendarVerticalView
    public var lineBackgroundColor: AColor

    // MARK: - Initializer

    public init(theme: AppTheme) {
        backgroundColor = theme.colors.backgroundBasic
        lineBackgroundColor = theme.colors.backgroundAdditionalOne
    }
    
}
