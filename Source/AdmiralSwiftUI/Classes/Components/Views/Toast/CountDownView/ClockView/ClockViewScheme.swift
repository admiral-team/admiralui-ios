//
//  ClockViewScheme.swift
//  AdmiralSwiftUI
//
//  Created on 18.08.2022.
//

import AdmiralTheme
import AdmiralUIResources
/**
 ClockScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - ClockScheme() - Initialize default ClockScheme with default themezation
 # Example to create ClockScheme:
 # Code
 ```
 let scheme = ClockScheme()
 ```
 */
public struct ClockScheme: AppThemeScheme {

    // MARK: - Properties

    /// The text color
    public var textColor: AColor

    /// The text color
    public var textFont: AFont

    // MARK: - Initializer

    public init(theme: AppTheme = .default) {
        textColor = theme.colors.textAccent
        textFont = theme.fonts.subhead3
    }

}
