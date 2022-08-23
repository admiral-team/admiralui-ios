//
//  ClockViewScheme.swift
//  AdmiralSwiftUI
//
//  Created on 18.08.2022.
//

import AdmiralTheme
import AdmiralUIResources

struct ClockScheme: AppThemeScheme {

    // MARK: - Properties

    /// The text color of ClockView
    var textColor: AColor

    /// The text color of ClockView
    var textFont: AFont

    // MARK: - Initializer

    init(theme: AppTheme) {
        textColor = theme.colors.textAccent
        textFont = theme.fonts.subhead3
    }
}
