//
//  MonthYearViewStyle.swift
//  AdmiralSwiftUI
//
//  Created on 09.06.2021.
//
import AdmiralCore
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
public struct MonthYearViewScheme: AppThemeScheme {

    // MARK: - Public Properties

    /// The title label color
    public var titleLabelColor: AColor

    /// The background color
    public var backgroundColor: AColor

    /// The title label font
    public var titleLabelFont: AFont

    // MARK: - Initializer

    public init(theme: AppTheme = .default) {
        titleLabelFont = theme.fonts.subtitle1

        backgroundColor = theme.colors.backgroundBasic
        titleLabelColor = theme.colors.textPrimary
    }

}
