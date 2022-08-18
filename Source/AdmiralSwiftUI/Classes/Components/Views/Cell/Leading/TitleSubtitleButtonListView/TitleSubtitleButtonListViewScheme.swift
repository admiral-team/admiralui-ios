//
//  TitleSubtitleButtonListViewStyle.swift
//  AdmiralSwiftUI
//
//  Created on 07.06.2021.
//

import AdmiralTheme
import AdmiralUIResources

public struct TitleSubtitleButtonListViewScheme: AppThemeScheme {

    // MARK: - Properties

    /// The background color of TitleSubtitleButtonListView
    public var backgroundColor = ControlParameter<AColor>()

    /// The title label color of TitleSubtitleButtonListView
    public var titleLabelTextColor = ControlParameter<AColor>()

    /// The subtitle color of TitleSubtitleButtonListView
    public var subtitleTagLabelTextColor = ControlParameter<AColor>()

    /// The button title color of TitleSubtitleButtonListView
    public var buttonTitleColor = ControlParameter<AColor>()

    /// The subtitle color of TitleSubtitleButtonListView
    public var subtitleLabelTextColor = ControlParameter<AColor>()

    /// The tag view backgorund color of TitleSubtitleButtonListView
    public var tagViewBackgroundColor = ControlParameter<AColor>()

    /// The title font color of TitleSubtitleButtonListView
    public var titleFont: AFont

    /// The  title font of TitleSubtitleButtonListView
    public var subtitleTagFont: AFont

    /// The  title font of TitleSubtitleButtonListView
    public var subtitleFont: AFont

    /// The tag view font color of TitleSubtitleButtonListView
    public var tagViewFont: AFont

    /// The ghost button font color of TitleSubtitleButtonListView
    public var ghostButtonFont: AFont

    // MARK: - Initializer

    public init() {
        self.init(theme: AppTheme.default)
    }

    public init(theme: AppTheme) {
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
