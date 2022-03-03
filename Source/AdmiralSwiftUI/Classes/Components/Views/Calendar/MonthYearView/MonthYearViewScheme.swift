//
//  MonthYearViewStyle.swift
//  AdmiralSwiftUI
//
//  Created on 09.06.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources

@available(iOS 14.0.0, *)
public struct MonthYearViewScheme: AppThemeScheme {
    
    public var titleLabelColor: AColor
    public var backgroundColor: AColor
    public var titleLabelFont: AFont
    
    public init(theme: AppTheme) {
        titleLabelFont = theme.fonts.subtitle1
        
        backgroundColor = theme.colors.backgroundBasic
        titleLabelColor = theme.colors.textPrimary
    }
    
}
