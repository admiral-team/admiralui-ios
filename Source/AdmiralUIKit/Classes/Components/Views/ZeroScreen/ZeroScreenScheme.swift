//
//  ZeroScreenScheme.swift
//  AdmiralUIResources
//
//  Created on 16.02.2022.
//

import AdmiralCore
import AdmiralTheme
import AdmiralUIResources

/**
 ZeroScreenScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - ZeroScreenScheme() - Initialize default ZeroScreenScheme with default themezation
Example to create ZeroScreenScheme:
Code
 ```
let scheme = ZeroScreenScheme()
 ```
 */
public struct ZeroScreenScheme: AppThemeScheme {

    /// Background color.
    public var backgroundColor: AColor

    /// Title color.
    public var titleColor: AColor

    /// Title font.
    public var titleFont: AFont

    /// Subtitle color.
    public var subtitleColor: AColor

    /// Subtitle font.
    public var subtitleFont: AFont

    /// Primary button scheme.
    public var primaryButtonScheme: PrimaryButtonCustomScheme

    public init(theme: AppTheme = .default) {
        backgroundColor = theme.colors.backgroundBasic
        
        titleColor = theme.colors.textPrimary
        titleFont = theme.fonts.title1
        
        subtitleColor = theme.colors.textSecondary
        subtitleFont = theme.fonts.body2
        
        primaryButtonScheme = PrimaryButtonCustomScheme(theme: theme)
    }
}
