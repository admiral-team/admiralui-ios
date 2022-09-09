//
//  MonthYearViewStyle.swift
//  AdmiralSwiftUI
//
//  Created on 09.06.2021.
//
import AdmiralTheme
import AdmiralUIResources
/**
 MonthYearViewScheme - the visual scheme of MonthYearView.
 You can create a by specifying the following parameters in init:
 - MonthYearViewScheme() - Initialize default MonthYearViewScheme with default themezation
 # Example to create MonthYearViewScheme:
 # Code
 ```
 let scheme = MonthYearViewScheme()
 ```
 */
@available(iOS 14.0.0, *)
struct MonthYearViewScheme: AppThemeScheme {

    // MARK: - Properties

    /// The title label color
    var titleLabelColor: AColor

    /// The background color
    var backgroundColor: AColor

    /// The title label font
    var titleLabelFont: AFont

    // MARK: - Initializer

    init(theme: AppTheme = .default) {
        titleLabelFont = theme.fonts.subtitle1

        backgroundColor = theme.colors.backgroundBasic
        titleLabelColor = theme.colors.textPrimary
    }

}
