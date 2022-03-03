//
//  TitleSubtitleButtonListViewStyle.swift
//  AdmiralSwiftUI
//
//  Created on 07.06.2021.
//

import AdmiralTheme
import AdmiralUIResources

public struct TitleSubtitleButtonListViewScheme: AppThemeScheme {
    
    public var backgroundColor = ControlParameter<AColor>()
    public var titleLabelTextColor = ControlParameter<AColor>()
    public var subtitleTagLabelTextColor = ControlParameter<AColor>()
    public var buttonTitleColor = ControlParameter<AColor>()
    public var subtitleLabelTextColor = ControlParameter<AColor>()
    public var tagViewBackgroundColor = ControlParameter<AColor>()
    
    public var titleFont: AFont
    public var subtitleTagFont: AFont
    public var subtitleFont: AFont
    public var tagViewFont: AFont
    public var ghostButtonFont: AFont
    
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
