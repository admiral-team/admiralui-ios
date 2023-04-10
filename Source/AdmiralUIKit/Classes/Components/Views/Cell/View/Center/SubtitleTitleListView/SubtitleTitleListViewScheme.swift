//
//  SubtitleTitleListViewScheme.swift
//  AdmiralUI
//
//  Created on 26.11.2020.
//

import AdmiralCore
import AdmiralTheme
import AdmiralUIResources

/**
 SubtitleTitleListViewScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - SubtitleTitleListViewScheme() - Initialize default SubtitleTitleListViewScheme with default themezation
Example to create SubtitleTitleListViewScheme:
Code
 ```
let scheme = SubtitleTitleListViewScheme()
 ```
 */
public struct SubtitleTitleListViewScheme: AppThemeScheme {

    /// Background color.
    public var backgroundColor = ControlParameter<AColor>()

    /// Title color.
    public var titleColor = ControlParameter<AColor>()

    /// Subtitle color.
    public var subtitleColor = ControlParameter<AColor>()

    /// Title font.
    public var titleFont: AFont

    /// Subtitle font.
    public var subtitleFont: AFont

    public init(theme: AppTheme = .default) {
        let alpha = theme.colors.disabledAlpha

        backgroundColor.set(parameter: theme.colors.backgroundSelected, for: .highlighted)
        backgroundColor.set(parameter: theme.colors.backgroundBasic, for: .normal)
        
        titleColor.set(parameter: theme.colors.textSecondary.withAlpha(alpha), for: .disabled)
        titleColor.set(parameter: theme.colors.textPrimary, for: .normal)
        
        subtitleColor.set(parameter: theme.colors.textSecondary.withAlpha(alpha), for: .disabled)
        subtitleColor.set(parameter: theme.colors.textSecondary, for: .normal)
        
        titleFont = theme.fonts.body1
        subtitleFont = theme.fonts.subhead4
    }
}
