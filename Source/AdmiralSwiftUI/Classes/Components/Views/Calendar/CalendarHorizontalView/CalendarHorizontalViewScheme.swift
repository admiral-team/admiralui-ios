//
//  CalendarHorizontalViewScheme.swift
//  AdmiralSwiftUI
//
//  Created on 15.09.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources

@available(iOS 14.0.0, *)
public struct CalendarHorizontalViewScheme: AppThemeScheme {

    // MARK: - Properties

    /// The picker title color of CalendarHorizontalView
    public var pickerTitleColor: AColor

    // MARK: - Initializer

    public init(theme: AppTheme) {
        pickerTitleColor = theme.colors.textPrimary
    }
    
}
