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
    
    public var backgroundColor: AColor
    public var lineBackgroundColor: AColor
    
    public init(theme: AppTheme) {
        backgroundColor = theme.colors.backgroundBasic
        lineBackgroundColor = theme.colors.backgroundAdditionalOne
    }
    
}
