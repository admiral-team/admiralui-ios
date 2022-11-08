//
//  TitleLargeSubtitleScheme.swift
//  AdmiralUI
//
//  Created on 26.02.2021.
//

import UIKit
import AdmiralTheme
import AdmiralUIResources

/**
 TitleLargeSubtitleScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - TitleLargeSubtitleScheme() - Initialize default TitleLargeSubtitleScheme with default themezation
Example to create TitleLargeSubtitleScheme:
Code
 ```
let scheme = TitleLargeSubtitleScheme()
 ```
 */
public struct TitleLargeSubtitleScheme: AppThemeScheme {

    /// Background color.
    public var backgroundColor = ControlParameter<AColor>()

    /// Title color.
    public var titleColor = ControlParameter<AColor>()

    /// Subtitle color.
    public var subtitleColor = ControlParameter<AColor>()

    /// Additional color.
    public var additionaColor = ControlParameter<AColor>()

    /// Title font.
    public var titleFont: AFont

    /// Subtitle font.
    public var subtitleFont: AFont

    /// Additional title font.
    public var additionalTitleFont: AFont
    
    public init(theme: AppTheme = .default) {
        let alpha = theme.colors.disabledAlpha

        backgroundColor.set(parameter: theme.colors.backgroundSelected, for: .highlighted)
        backgroundColor.set(parameter: theme.colors.backgroundBasic, for: .normal)
        
        titleColor.set(parameter: theme.colors.textPrimary.withAlpha(alpha), for: .disabled)
        titleColor.set(parameter: theme.colors.textPrimary, for: .normal)
        
        subtitleColor.set(parameter: theme.colors.textSecondary.withAlpha(alpha), for: .disabled)
        subtitleColor.set(parameter: theme.colors.elementAccent, for: .normal)
        
        additionaColor.set(parameter: theme.colors.textSecondary.withAlpha(alpha), for: .disabled)
        additionaColor.set(parameter: theme.colors.textSecondary, for: .normal)
        
        titleFont = theme.fonts.body1
        subtitleFont = theme.fonts.subtitle2
        additionalTitleFont = theme.fonts.subhead3
    }
}
