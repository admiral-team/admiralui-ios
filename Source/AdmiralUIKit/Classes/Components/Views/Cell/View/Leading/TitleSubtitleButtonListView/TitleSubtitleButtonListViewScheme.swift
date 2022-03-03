//
//  TitleSubtitleButtonListViewScheme.swift
//  AdmiralUI
//
//  Created on 27.11.2020.
//

import AdmiralTheme
import AdmiralUIResources

struct TitleSubtitleButtonListViewScheme {
    
    var backgroundColor = ControlParameter<AColor>()
    var titleLabelTextColor = ControlParameter<AColor>()
    var subtitleTagLabelTextColor = ControlParameter<AColor>()
    var buttonTitleColor = ControlParameter<AColor>()
    var subtitleLabelTextColor = ControlParameter<AColor>()
    
    var titleFont: AFont
    var subtitleTagFont: AFont
    var subtitleFont: AFont
    var tagViewFont: AFont
    var ghostButtonFont: AFont
    
    init() {
        self.init(theme: AppTheme.default)
    }
    
    init(theme: AppTheme) {
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
