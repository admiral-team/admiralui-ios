//
//  TitleMoreDetailTextMessageListViewStyle.swift
//  AdmiralSwiftUI
//
//  Created on 07.06.2021.
//

import AdmiralTheme
import AdmiralUIResources

public struct TitleMoreDetailTextMessageListViewScheme: AppThemeScheme {

    // MARK: - Properties

    /// The background color of TitleMoreDetailTextMessageListView
    public var backgroundColor = ControlParameter<AColor>()

    /// The title color of TitleMoreDetailTextMessageListView
    public var titleLabelTextColor = ControlParameter<AColor>()

    /// The moreLabel color of TitleMoreDetailTextMessageListView
    public var moreLabelTextColor = ControlParameter<AColor>()

    /// The detaileTitle color of TitleMoreDetailTextMessageListView
    public var detaileTitleLabelTextColor = ControlParameter<AColor>()

    /// The detaileMore color of TitleMoreDetailTextMessageListView
    public var detaileMoreLabelTextColor = ControlParameter<AColor>()

    /// The subtitle color of TitleMoreDetailTextMessageListView
    public var subtitleLabelTextColor = ControlParameter<AColor>()

    /// The infoImage color of TitleMoreDetailTextMessageListView
    public var infoImageViewTintColor = ControlParameter<AColor>()

    /// The message color of TitleMoreDetailTextMessageListView
    public var messageTitleLabelTitleColor = ControlParameter<AColor>()

    /// The messageView backgroundColor of TitleMoreDetailTextMessageListView
    public var messageViewBackgroundColor = ControlParameter<AColor>()

    /// The title font of TitleMoreDetailTextMessageListView
    public var titleFont: AFont

    /// The subtitle font of TitleMoreDetailTextMessageListView
    public var subtitleFont: AFont

    /// The more font of TitleMoreDetailTextMessageListView
    public var moreFont: AFont

    /// The detaile font of TitleMoreDetailTextMessageListView
    public var detaileTitleFont: AFont

    /// The detaile font of TitleMoreDetailTextMessageListView
    public var detaileMoreFont: AFont

    /// The tag font of TitleMoreDetailTextMessageListView
    public var tagViewFont: AFont

    /// The message font of TitleMoreDetailTextMessageListView
    public var messageTitleFont: AFont

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
        
        moreLabelTextColor.set(parameter: theme.colors.textSecondary, for: .normal)
        moreLabelTextColor.set(parameter: theme.colors.textSecondary.withAlpha(alpha), for: .disabled)
        
        detaileTitleLabelTextColor.set(parameter: theme.colors.elementAccent, for: .normal)
        detaileTitleLabelTextColor.set(parameter: theme.colors.elementAccent.withAlpha(alpha), for: .disabled)
        
        detaileMoreLabelTextColor.set(parameter: theme.colors.textAccentAdditional, for: .normal)
        detaileMoreLabelTextColor.set(parameter: theme.colors.textAccentAdditional.withAlpha(alpha), for: .disabled)
        
        subtitleLabelTextColor.set(parameter: theme.colors.textSecondary, for: .normal)
        subtitleLabelTextColor.set(parameter: theme.colors.textSecondary.withAlpha(alpha), for: .disabled)
        
        infoImageViewTintColor.set(parameter: theme.colors.textSecondary, for: .normal)
        infoImageViewTintColor.set(parameter: theme.colors.textSecondary.withAlpha(alpha), for: .disabled)
        
        messageTitleLabelTitleColor.set(parameter: theme.colors.textPrimary, for: .normal)
        messageTitleLabelTitleColor.set(parameter: theme.colors.textPrimary.withAlpha(alpha), for: .disabled)
        
        messageViewBackgroundColor.set(parameter: theme.colors.backgroundAdditionalOne, for: .normal)
        messageViewBackgroundColor.set(parameter: theme.colors.backgroundAdditionalOne.withAlpha(alpha), for: .disabled)
        
        titleFont = theme.fonts.body1
        subtitleFont = theme.fonts.subhead3
        moreFont = theme.fonts.subhead3
        detaileTitleFont = theme.fonts.subtitle2
        detaileMoreFont = theme.fonts.subhead3
        tagViewFont = theme.fonts.caption2
        messageTitleFont = theme.fonts.subhead4
    }
}
