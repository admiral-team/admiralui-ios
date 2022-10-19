//
//  TitleMoreDetailTextMessageListViewScheme.swift
//  AdmiralUI
//
//  Created on 27.11.2020.
//

import AdmiralTheme
import AdmiralUIResources

struct TitleMoreDetailTextMessageListViewScheme {
    
    var backgroundColor = ControlParameter<AColor>()
    var titleLabelTextColor = ControlParameter<AColor>()
    var moreLabelTextColor = ControlParameter<AColor>()
    var detaileTitleLabelTextColor = ControlParameter<AColor>()
    var detaileMoreLabelTextColor = ControlParameter<AColor>()
    var subtitleLabelTextColor = ControlParameter<AColor>()
    var infoImageViewTintColor = ControlParameter<AColor>()
    var messageTitleLabelTitleColor = ControlParameter<AColor>()
    var messageViewBackgroundColor = ControlParameter<AColor>()
    
    var titleFont: AFont
    var subtitleFont: AFont
    var moreFont: AFont
    var detaileTitleFont: AFont
    var detaileMoreFont: AFont
    var tagViewFont: AFont
    var messageTitleFont: AFont
    
    init() {
        self.init(theme: AppTheme.default)
    }
    
    init(theme: AppTheme) {
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
