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
struct MonthYearViewScheme: AppThemeScheme {

    // MARK: - Properties

    /// The title label color of MonthYearView
    var titleLabelColor: AColor

    /// The background color of MonthYearView
    var backgroundColor: AColor

    /// The title label font of MonthYearView
    var titleLabelFont: AFont

    // MARK: - Initializer

    init(theme: AppTheme) {
        titleLabelFont = theme.fonts.subtitle1
        
        backgroundColor = theme.colors.backgroundBasic
        titleLabelColor = theme.colors.textPrimary
    }
    
}
