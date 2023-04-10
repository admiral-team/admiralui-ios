//
//  StatusHistoryDateViewScheme.swift
//  AdmiralUI
//
//  Created on 23.12.2020.
//

import AdmiralCore
import AdmiralTheme
import AdmiralUIResources

/**
 StatusHistoryViewScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - StatusHistoryViewScheme() - Initialize default StatusHistoryViewScheme with default themezation
Example to create StatusHistoryViewScheme:
Code
 ```
let scheme = StatusHistoryViewScheme()
 ```
 */
public struct StatusHistoryDateViewScheme: AppThemeScheme {

    /// Text font.
    public var textFont: AFont

    /// Text color.
    public var textColor: AColor

    /// Button tint color.
    public var buttonTintColor: AColor

    public init(theme: AppTheme = .default) {
        textFont = theme.fonts.body2
        textColor = theme.colors.textPrimary
        buttonTintColor = theme.colors.textSecondary
    }
}
