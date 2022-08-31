//
//  ClockViewScheme.swift
//  AdmiralSwiftUI
//
//  Created on 18.08.2022.
//

import AdmiralTheme
import AdmiralUIResources
/**
 ClockScheme - the visual scheme of ClockView.
 You can create a by specifying the following parameters in init:
 - ClockScheme() - Initialize default ClockScheme with default themezation
 - ClockScheme(
 textColor: AColor,
 textFont: AFont
 )
 # Example to create ClockScheme:
 # Code
 ```
 let scheme = ClockScheme()
 ```
 */
struct ClockScheme: AppThemeScheme {

    // MARK: - Properties

    /// The text color of ClockView
    var textColor: AColor

    /// The text color of ClockView
    var textFont: AFont

    // MARK: - Initializer

    init(theme: AppTheme = .default) {
        textColor = theme.colors.textAccent
        textFont = theme.fonts.subhead3
    }

    init(
        textColor: AColor,
        textFont: AFont
    ) {
        self.textColor = textColor
        self.textFont = textFont
    }
}
