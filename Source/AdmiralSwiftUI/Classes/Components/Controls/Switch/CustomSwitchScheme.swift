//
//  CustomSwitchStyle.swift
//  AdmiralSwiftUI
//
//  Created on 12.04.2021.
//

import SwiftUI
import AdmiralTheme
/**
 CustomSwitchScheme - the visual scheme.
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

    // MARK: - Public Properties

    /// The font
    public var font: AFont

    /// The tint color
    public var tintColor: AColor

    /// The text color
    public var textColor: AColor

    // MARK: - Initializer

    public init(theme: AppTheme = .default) {
        font = theme.fonts.body1
        tintColor = theme.colors.elementAccent
        textColor = theme.colors.textPrimary
    }

}
