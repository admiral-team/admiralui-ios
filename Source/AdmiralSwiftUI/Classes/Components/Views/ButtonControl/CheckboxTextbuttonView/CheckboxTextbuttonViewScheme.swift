//
//  CheckboxTextbuttonViewScheme.swift
//  AdmiralUIResources
//
//  Created on 26.11.2021.
//

import AdmiralTheme
import AdmiralUIResources

public struct CheckboxTextbuttonViewScheme: AppThemeScheme {

    // MARK: - Public Properties

    /// The title font of CheckboxTextbuttonView
    public var titleFont: AFont

    /// The text color of CheckboxTextbuttonView
    public var textColor = ControlParameter<AColor>()

    // MARK: - Initializer

    public init(theme: AppTheme) {
        let alpha = theme.colors.disabledAlpha

        titleFont = theme.fonts.subhead4

        textColor.set(parameter: theme.colors.textPrimary, for: .normal)
        textColor.set(parameter: theme.colors.textPrimary.withAlpha(alpha), for: .disabled)
    }
}

