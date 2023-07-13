//
//  CalendarActivityIndicatorScheme.swift
//  AdmiralCalendarSwiftUI
//
//  Created on 02.09.2021.
//

import AdmiralTheme
/**
 CalendarActivityIndicatorScheme - the visual scheme of ActivityIndicator.
  You can create a by specifying the following parameters in init:
  - CalendarActivityIndicatorScheme() - Initialize default CalendarActivityIndicatorScheme with default themezation
  # Example to create CalendarActivityIndicatorScheme:
  # Code
  ```
 let scheme = CalendarActivityIndicatorScheme()
  ```
*/
public struct CalendarActivityIndicatorScheme: AppThemeScheme {

    // MARK: - Public Properties

    /// The background color that configure with state
    public var backgroundDefaultColor = ControlParameter<AColor>()

    /// The background color constrast that configure with state
    public var backgroundConstrastColor = ControlParameter<AColor>()

    // MARK: - Initializer

    public init(theme: AppTheme = .default) {
        let alpha = theme.colors.disabledAlpha

        backgroundDefaultColor.set(parameter: theme.colors.elementStaticWhite, for: .normal)
        backgroundDefaultColor.set(parameter: theme.colors.elementStaticWhite.withAlpha(alpha), for: .disabled)

        backgroundConstrastColor.set(parameter: theme.colors.elementAccent, for: .normal)
        backgroundConstrastColor.set(parameter: theme.colors.elementAccent.withAlpha(alpha), for: .disabled)
    }

}
