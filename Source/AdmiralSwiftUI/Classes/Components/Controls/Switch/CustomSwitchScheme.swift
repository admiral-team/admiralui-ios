//
//  CustomSwitchStyle.swift
//  AdmiralSwiftUI
//
//  Created on 12.04.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources
/**
 CustomSwitchScheme - the visual scheme of CustomSwitch.
 You can create a by specifying the following parameters in init:
 - CustomSwitchScheme() - Initialize default CustomSwitchScheme with default themezation
 - CustomSwitchScheme(
     font: AFont,
     onTintColorColor: AColor,
     textColor: AColor
   )
 # Example to create CustomSwitchScheme:
 # Code
 ```
let scheme = CustomSwitchScheme()
 ```
 */
@available(iOS 14.0.0, *)
public struct CustomSwitchScheme: AppThemeScheme  {

    // MARK: - Properties

    /// The font of CustomSwitch
    public let font: AFont

    /// The tint color of CustomSwitch
    public let onTintColorColor: AColor

    /// The text color of CustomSwitch
    public let textColor: AColor

    // MARK: - Initializer

    public init() {
        self.init(theme: AppTheme.default)
    }

    public init(theme: AppTheme) {
        font = theme.fonts.body1
        onTintColorColor = theme.colors.elementAccent
        textColor = theme.colors.textPrimary
    }

    public init(
        font: AFont,
        onTintColorColor: AColor,
        textColor: AColor
    ) {
        self.font = font
        self.onTintColorColor = onTintColorColor
        self.textColor = textColor
    }

}
