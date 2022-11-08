//
//  TitleSubtitleButtonListViewScheme.swift
//  AdmiralUI
//
//  Created on 27.11.2020.
//

import AdmiralTheme
import AdmiralUIResources

/**
 TitleSubtitleButtonListViewScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - TitleSubtitleButtonListViewScheme() - Initialize default TitleSubtitleButtonListViewScheme with default themezation
Example to create TitleSubtitleButtonListViewScheme:
Code
 ```
let scheme = TitleSubtitleButtonListViewScheme()
 ```
 */
public struct TitleSubtitleButtonListViewScheme: AppThemeScheme {

    /// Background color.
    public var backgroundColor = ControlParameter<AColor>()

    /// Title label text color.
    public var titleLabelTextColor = ControlParameter<AColor>()

    /// Subtitle tag label text color.
    public var subtitleTagLabelTextColor = ControlParameter<AColor>()

    /// Button title color.
    public var buttonTitleColor = ControlParameter<AColor>()

    /// Subtitle label text color.
    public var subtitleLabelTextColor = ControlParameter<AColor>()

    /// Title font.
    public var titleFont: AFont

    /// Subtitle tag font.
    public var subtitleTagFont: AFont

    /// Subtitle font.
    public var subtitleFont: AFont

    /// Tag view font.
    public var tagViewFont: AFont

    /// Ghost button font.
    public var ghostButtonFont: AFont
    
    public init(theme: AppTheme = .default) {
        let alpha = theme.colors.disabledAlpha

        backgroundColor.set(parameter: theme.colors.backgroundSelected, for: .highlighted)
        backgroundColor.set(parameter: theme.colors.backgroundBasic, for: .normal)
        
        titleLabelTextColor.set(parameter: theme.colors.textPrimary, for: .normal)
        titleLabelTextColor.set(parameter: theme.colors.textPrimary.withAlpha(alpha), for: .disabled)
        
        subtitleTagLabelTextColor.set(parameter: theme.colors.textPrimary, for: .normal)
        subtitleTagLabelTextColor.set(parameter: theme.colors.textPrimary.withAlpha(alpha), for: .disabled)
        subtitleLabelTextColor.set(parameter: theme.colors.textSecondary, for: .normal)
        subtitleLabelTextColor.set(parameter: theme.colors.textSecondary.withAlpha(alpha), for: .disabled)
        
        buttonTitleColor.set(parameter: theme.colors.textAccent, for: .normal)
        buttonTitleColor.set(parameter: theme.colors.textAccent.withAlpha(alpha), for: .disabled)
        
        titleFont = theme.fonts.body1
        subtitleTagFont = theme.fonts.subhead4
        subtitleFont = theme.fonts.subhead4
        tagViewFont = theme.fonts.caption2
        ghostButtonFont = theme.fonts.body1
    }
}
