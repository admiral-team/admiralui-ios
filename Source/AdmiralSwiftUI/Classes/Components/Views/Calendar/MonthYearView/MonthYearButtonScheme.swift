//
//  MonthYearButtonStyle.swift
//  AdmiralSwiftUI
//
//  Created on 13.07.2021.
//

import SwiftUI
import AdmiralCore
import AdmiralTheme
import AdmiralUIResources
/**
 MonthYearButtonScheme - the visual scheme of MonthYearButtonStyle.
 You can create a by specifying the following parameters in init:
 - MonthYearButtonScheme() - Initialize default MonthYearButtonScheme with default themezation
 # Example to create MonthYearButtonScheme:
 # Code
 ```
 let scheme = MonthYearButtonScheme()
 ```
 */
@available(iOS 14.0.0, *)
public struct MonthYearButtonScheme: AppThemeScheme {

    // MARK: - Properties

    /// The font
    public var font: AFont

    /// The text color
    public var textColor = ControlParameter<AColor>()

    // MARK: - Initializer

    public init(theme: AppTheme = .default) {
        let alpha = theme.colors.disabledAlpha
        font = theme.fonts.subtitle1
        textColor.set(parameter: theme.colors.textAccent, for: .normal)
        textColor.set(parameter: theme.colors.textAccentPressed, for: .highlighted)
        textColor.set(parameter: theme.colors.textAccent.withAlpha(alpha), for: .disabled)
    }

}
