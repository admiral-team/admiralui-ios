//
//  ActivityIndicatorScheme.swift
//  AdmiralSwiftUI
//
//  Created on 02.09.2021.
//

import AdmiralTheme
import AdmiralUIResources
/**
 ActivityIndicatorScheme - the visual scheme of PlatformButtonStyle.
  You can create a by specifying the following parameters in init:
  - ActivityIndicatorScheme() - Initialize default ActivityIndicatorScheme with default themezation
  - ActivityIndicatorScheme(
     backgroundColorNormal: AColor,
     backgroundColorDisabled: AColor,
     backgroundConstrastNormal: AColor,
     backgroundConstrastDisabled: AColor
    )
  # Example to create ArrowSegmentSliderScheme:
  # Code
  ```
 let scheme = ActivityIndicatorScheme()
  ```
*/
public struct ActivityIndicatorScheme: AppThemeScheme {

    // MARK: - Properties

    /// The background color of ActivityIndicator
    public var backgroundDefaultColor = ControlParameter<AColor>()

    /// The background constant color of ActivityIndicator
    public var backgroundConstrastColor = ControlParameter<AColor>()

    // MARK: - Initializer

    public init(theme: AppTheme = .default) {
        let alpha = theme.colors.disabledAlpha

        backgroundDefaultColor.set(parameter: theme.colors.elementStaticWhite, for: .normal)
        backgroundDefaultColor.set(parameter: theme.colors.elementStaticWhite.withAlpha(alpha), for: .disabled)

        backgroundConstrastColor.set(parameter: theme.colors.elementAccent, for: .normal)
        backgroundConstrastColor.set(parameter: theme.colors.elementAccent.withAlpha(alpha), for: .disabled)
    }

    public init(
        backgroundColorNormal: AColor,
        backgroundColorDisabled: AColor,
        backgroundConstrastNormal: AColor,
        backgroundConstrastDisabled: AColor
    ) {
        backgroundDefaultColor.set(parameter: backgroundColorNormal, for: .normal)
        backgroundDefaultColor.set(parameter: backgroundColorDisabled, for: .disabled)

        backgroundConstrastColor.set(parameter: backgroundConstrastNormal, for: .normal)
        backgroundConstrastColor.set(parameter: backgroundConstrastDisabled, for: .disabled)
    }

}

