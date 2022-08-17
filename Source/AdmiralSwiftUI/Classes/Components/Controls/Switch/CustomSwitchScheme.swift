//
//  CustomSwitchStyle.swift
//  AdmiralSwiftUI
//
//  Created on 12.04.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources

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

}
