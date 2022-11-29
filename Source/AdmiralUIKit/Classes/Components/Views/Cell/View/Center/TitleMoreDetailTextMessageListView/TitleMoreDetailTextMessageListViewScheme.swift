//
//  TitleMoreDetailTextMessageListViewScheme.swift
//  AdmiralUI
//
//  Created on 27.11.2020.
//

import AdmiralTheme
import AdmiralUIResources

/**
 TitleMoreDetailTextMessageListViewScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - TitleMoreDetailTextMessageListViewScheme() - Initialize default TitleMoreDetailTextMessageListViewScheme with default themezation
Example to create TitleMoreDetailTextMessageListViewScheme:
Code
 ```
let scheme = TitleMoreDetailTextMessageListViewScheme()
 ```
 */
public struct TitleMoreDetailTextMessageListViewScheme: AppThemeScheme {

    /// Background color.
    public var backgroundColor = ControlParameter<AColor>()

    /// Title label text color.
    public var titleLabelTextColor = ControlParameter<AColor>()

    /// Mode label text color.
    public var moreLabelTextColor = ControlParameter<AColor>()

    /// Detaile title label text color.
    public var detaileTitleLabelTextColor = ControlParameter<AColor>()

    /// Detail more label text color.
    public var detaileMoreLabelTextColor = ControlParameter<AColor>()

    /// Subtitle label text color.
    public var subtitleLabelTextColor = ControlParameter<AColor>()

    /// Info image tint color.
    public var infoImageViewTintColor = ControlParameter<AColor>()

    /// Message title label text color.
    public var messageTitleLabelTitleColor = ControlParameter<AColor>()

    /// Message view background color.
    public var messageViewBackgroundColor = ControlParameter<AColor>()

    /// Title font.
    public var titleFont: AFont

    /// Subtitle font.
    public var subtitleFont: AFont

    /// More label font.
    public var moreFont: AFont

    /// Detaile title font.
    public var detaileTitleFont: AFont

    /// Detaile more font.
    public var detaileMoreFont: AFont

    /// Tag view font.
    public var tagViewFont: AFont

    /// Message title font.
    public var messageTitleFont: AFont
    
    public init(theme: AppTheme = .default) {
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
        
        titleFont = theme.fonts.body1
        subtitleFont = theme.fonts.subhead3
        moreFont = theme.fonts.subhead3
        detaileTitleFont = theme.fonts.subtitle2
        detaileMoreFont = theme.fonts.subhead3
        tagViewFont = theme.fonts.caption2
        messageTitleFont = theme.fonts.subhead4
    }
}
