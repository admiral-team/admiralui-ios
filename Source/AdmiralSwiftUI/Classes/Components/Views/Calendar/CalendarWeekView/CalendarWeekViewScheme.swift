//
//  CalendarWeekViewStyle.swift
//  AdmiralSwiftUI
//
//  Created on 09.06.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources

@available(iOS 14.0.0, *)
public struct CalendarWeekViewScheme: AppThemeScheme {

    // MARK: - Properties

    /// The title label color of CalendarWeekView
    public var titleLabelColor: AColor

    /// The background of CalendarWeekView
    public var backgroundColor: AColor

    /// The title label font of CalendarWeekView
    public var titleLabelFont: AFont

    // MARK: - Initializer

    public init(theme: AppTheme) {
        titleLabelFont = theme.fonts.subhead2
        
        backgroundColor = theme.colors.backgroundBasic
        titleLabelColor = theme.colors.textSecondary
    }
    
}
