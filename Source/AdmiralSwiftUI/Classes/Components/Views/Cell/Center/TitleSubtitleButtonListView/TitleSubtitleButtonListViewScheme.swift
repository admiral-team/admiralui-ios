//
//  TitleSubtitleButtonListViewStyle.swift
//  AdmiralSwiftUI
//
//  Created on 07.06.2021.
//

import AdmiralCore
import AdmiralTheme
import AdmiralUIResources
/**
 TitleSubtitleButtonListViewScheme - the visual scheme of TitleSubtitleButtonListView.
 You can create a by specifying the following parameters in init:
 - TitleSubtitleButtonListViewScheme() - Initialize default TitleSubtitleButtonListViewScheme with default themezation
 # Example to create TitleSubtitleButtonListViewScheme:
 # Code
 ```
 let scheme = TitleSubtitleButtonListViewScheme()
 ```
 */
public struct TitleSubtitleButtonListViewScheme: AppThemeScheme {

    /// The  parameter that sets background color with state
    public var backgroundColor = ControlParameter<AColor>()

    /// The  parameter that sets title label text color with state
    public var titleLabelTextColor = ControlParameter<AColor>()

    /// The  parameter that sets subtitleTag label text color with state
    public var subtitleTagLabelTextColor = ControlParameter<AColor>()

    /// The  parameter that sets button title color with state
    public var buttonTitleColor = ControlParameter<AColor>()

    /// The  parameter that sets subtitle label text color with state
    public var subtitleLabelTextColor = ControlParameter<AColor>()

    /// The  parameter that sets tag view background color with state
    public var tagViewBackgroundColor = ControlParameter<AColor>()

    /// The title font
    public var titleFont: AFont

    /// The subtitle tag font
    public var subtitleTagFont: AFont

    /// The subtitle font
    public var subtitleFont: AFont

    /// The tag view font
    public var tagViewFont: AFont

    /// The ghost button font
    public var ghostButtonFont: AFont

    // MARK: - Initializer

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
        
        tagViewBackgroundColor.set(parameter: theme.colors.backgroundAdditionalOne, for: .normal)
        
        titleFont = theme.fonts.body1
        subtitleTagFont = theme.fonts.subhead4
        subtitleFont = theme.fonts.subhead4
        tagViewFont = theme.fonts.caption2
        ghostButtonFont = theme.fonts.body1
    }
}
