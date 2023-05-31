//
//  TitleMoreDetailTextMessageListViewStyle.swift
//  AdmiralSwiftUI
//
//  Created on 07.06.2021.
//

import AdmiralTheme
/**
 TitleMoreDetailTextMessageListViewScheme - the visual scheme of TitleMoreDetailTextMessageListView.
 You can create a by specifying the following parameters in init:
 - TitleMoreDetailTextMessageListViewScheme() - Initialize default TitleMoreDetailTextMessageListViewScheme with default themezation
 # Example to create TitleMoreDetailTextMessageListViewScheme:
 # Code
 ```
 let scheme = TitleMoreDetailTextMessageListViewScheme()
 ```
 */
@available(iOS 14.0, *)
public struct TitleMoreDetailTextMessageListViewScheme: AppThemeScheme {

    // MARK: - Public Properties

    /// The  parameter that sets background color with state
    public var backgroundColor = ControlParameter<AColor>()

    /// The  parameter that sets background color with state
    public var titleLabelTextColor = ControlParameter<AColor>()

    /// The  parameter that sets moreLabel text color with state
    public var moreLabelTextColor = ControlParameter<AColor>()

    /// The parameter that sets detaileTitle label  textwith state
    public var detaileTitleLabelTextColor = ControlParameter<AColor>()

    /// The parameter that sets detaileMore label with state
    public var detaileMoreLabelTextColor = ControlParameter<AColor>()

    /// The  parameter that sets subtitle label text color with state
    public var subtitleLabelTextColor = ControlParameter<AColor>()

    /// The  parameter that info image tint color with state
    public var infoImageViewTintColor = ControlParameter<AColor>()

    /// The  parameter that sets message title lebel color with state
    public var messageTitleLabelTitleColor = ControlParameter<AColor>()

    /// The  parameter that sets messageView background color with state
    public var messageViewBackgroundColor = ControlParameter<AColor>()

    /// The background color
    public var titleFont: AFont

    /// The subtitle font label color
    public var subtitleFont: AFont

    /// The more font
    public var moreFont: AFont

    /// The detail title font
    public var detaileTitleFont: AFont

    /// The detaile more font
    public var detaileMoreFont: AFont

    /// The tag view font
    public var tagViewFont: AFont

    /// The message title font
    public var messageTitleFont: AFont

    // MARK: - Initializer

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
