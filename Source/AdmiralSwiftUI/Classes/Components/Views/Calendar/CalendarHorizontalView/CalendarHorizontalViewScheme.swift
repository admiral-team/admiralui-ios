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
    
    public var pickerTitleColor: AColor
    
    public init(theme: AppTheme) {
        pickerTitleColor = theme.colors.textPrimary
    }
    
}
