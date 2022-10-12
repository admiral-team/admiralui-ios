//
//  GhostButtonWithImageStyle.swift
//  AdmiralSwiftUI
//
//  Created on 21.06.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources

@available(iOS 14.0.0, *)
public struct GhostButtonWithImageScheme: AppThemeScheme {

    // MARK: - Public Properties

    /// The font
    public var font: AFont

    /// The  parameter that sets text color with state
    public var textColor = ControlParameter<AColor>()

    /// The  parameter that sets image tint color with state
    public var imageColor = ControlParameter<AColor>()

    // MARK: - Initializer

    public init(theme: AppTheme = .default) {
        let alpha = theme.colors.disabledAlpha
        font = theme.fonts.body1
        textColor.set(parameter: theme.colors.textAccent, for: .normal)
        textColor.set(parameter: theme.colors.textAccentPressed, for: .highlighted)
        textColor.set(parameter: theme.colors.textAccent.withAlpha(alpha), for: .disabled)

        imageColor.set(parameter: theme.colors.elementAccent, for: .normal)
        imageColor.set(parameter: theme.colors.elementAccentPressed, for: .highlighted)
        imageColor.set(parameter: theme.colors.elementAccent.withAlpha(alpha), for: .disabled)
    }
}
