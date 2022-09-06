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
    public var font: AFont

    /// The tint color of CustomSwitch
    public var tintColor: AColor

    /// The text color of CustomSwitch
    public var textColor: AColor

    // MARK: - Initializer

    public init(theme: AppTheme = .default) {
        font = theme.fonts.body1
        tintColor = theme.colors.elementAccent
        textColor = theme.colors.textPrimary
    }

}
