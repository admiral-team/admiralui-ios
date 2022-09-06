//
//  CheckboxTextbuttonViewScheme.swift
//  AdmiralUIResources
//
//  Created on 26.11.2021.
//

import AdmiralTheme
import AdmiralUIResources
/**
 CheckboxTextbuttonViewScheme - the visual scheme of CheckboxTextbuttonView.
  You can create a by specifying the following parameters in init:
  - CheckboxTextbuttonViewScheme() - Initialize default CheckboxTextbuttonViewScheme with default themezation
  # Example to create CheckboxTextbuttonViewScheme:
  # Code
  ```
 let scheme = CheckboxTextbuttonViewScheme()
  ```
  */
public struct CheckboxTextbuttonViewScheme: AppThemeScheme {

    // MARK: - Public Properties

    /// The title font
    public var titleFont: AFont

    /// The text color
    public var textColor = ControlParameter<AColor>()

    // MARK: - Initializer

    public init(theme: AppTheme = .default) {
        let alpha = theme.colors.disabledAlpha

        titleFont = theme.fonts.subhead4

        textColor.set(parameter: theme.colors.textPrimary, for: .normal)
        textColor.set(parameter: theme.colors.textPrimary.withAlpha(alpha), for: .disabled)
    }
}

