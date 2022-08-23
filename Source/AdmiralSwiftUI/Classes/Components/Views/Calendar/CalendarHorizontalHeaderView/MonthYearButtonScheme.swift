//
//  MonthYearButtonStyle.swift
//  AdmiralSwiftUI
//
//  Created on 13.07.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources

@available(iOS 14.0.0, *)
public struct MonthYearButtonScheme: AppThemeScheme {

    // MARK: - Properties

    /// The font of MonthYearButton
    public let font: AFont

    /// The text color of MonthYearButton
    public var textColor = ControlParameter<AColor>()

    // MARK: - Initializer

    public init(theme: AppTheme) {
        let alpha = theme.colors.disabledAlpha
        font = theme.fonts.subtitle1
        textColor.set(parameter: theme.colors.textAccent, for: .normal)
        textColor.set(parameter: theme.colors.textAccentPressed, for: .highlighted)
        textColor.set(parameter: theme.colors.textAccent.withAlpha(alpha), for: .disabled)
    }
}
