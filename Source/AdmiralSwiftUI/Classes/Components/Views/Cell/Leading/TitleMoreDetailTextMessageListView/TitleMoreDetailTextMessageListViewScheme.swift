//
//  TitleMoreDetailTextMessageListViewStyle.swift
//  AdmiralSwiftUI
//
//  Created on 07.06.2021.
//

import AdmiralTheme
import AdmiralUIResources

public struct TitleMoreDetailTextMessageListViewScheme: AppThemeScheme {
    
    public var backgroundColor = ControlParameter<AColor>()
    public var titleLabelTextColor = ControlParameter<AColor>()
    public var moreLabelTextColor = ControlParameter<AColor>()
    public var detaileTitleLabelTextColor = ControlParameter<AColor>()
    public var detaileMoreLabelTextColor = ControlParameter<AColor>()
    public var subtitleLabelTextColor = ControlParameter<AColor>()
    public var infoImageViewTintColor = ControlParameter<AColor>()
    public var messageTitleLabelTitleColor = ControlParameter<AColor>()
    public var messageViewBackgroundColor = ControlParameter<AColor>()
    
    public var titleFont: AFont
    public var subtitleFont: AFont
    public var moreFont: AFont
    public var detaileTitleFont: AFont
    public var detaileMoreFont: AFont
    public var tagViewFont: AFont
    public var messageTitleFont: AFont
    
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
