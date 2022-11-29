//
//  StatusHistoryTitleViewScheme.swift
//  AdmiralUI
//
//  Created on 23.12.2020.
//

import UIKit
import AdmiralTheme
import AdmiralUIResources

/**
 StatusHistoryTitleViewScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - StatusHistoryTitleViewScheme() - Initialize default StatusHistoryTitleViewScheme with default themezation
Example to create StatusHistoryTitleViewScheme:
Code
 ```
let scheme = StatusHistoryTitleViewScheme()
 ```
 */
public struct StatusHistoryTitleViewScheme: AppThemeScheme {

    /// Title font.
    public var titleFont: AFont

    /// Title color.
    public var titleColor: AColor

    /// Subtitle font.
    public var subtitleFont: AFont

    /// Subtitle color.
    public var subtitleColor: AColor
    
    public init(theme: AppTheme = .default) {
        titleFont = theme.fonts.body1
        titleColor = theme.colors.textPrimary
        
        subtitleFont = theme.fonts.body2
        subtitleColor = theme.colors.textSecondary
    }
}
