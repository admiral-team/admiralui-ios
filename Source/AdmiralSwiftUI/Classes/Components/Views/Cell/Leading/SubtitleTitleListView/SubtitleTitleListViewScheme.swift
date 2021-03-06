//
//  SubtitleTitleListViewStyle.swift
//  AdmiralSwiftUI
//
//  Created on 07.06.2021.
//

import AdmiralTheme
import AdmiralUIResources

@available(iOS 14.0, *)
public struct SubtitleTitleListViewScheme: AppThemeScheme {
    
    public var backgroundColor = ControlParameter<AColor>()
    public var titleColor = ControlParameter<AColor>()
    public var subtitleColor = ControlParameter<AColor>()
    
    public var titleFont = TitleSubtitleListViewParameters<AFont>()
    public var subtitleFont = TitleSubtitleListViewParameters<AFont>()
    
    public init(theme: AppTheme) {
        let alpha = theme.colors.disabledAlpha

        backgroundColor.set(parameter: theme.colors.backgroundSelected, for: .highlighted)
        backgroundColor.set(parameter: theme.colors.backgroundBasic, for: .normal)
        
        titleColor.set(parameter: theme.colors.textPrimary.withAlpha(alpha), for: .disabled)
        titleColor.set(parameter: theme.colors.textPrimary, for: .normal)
        
        subtitleColor.set(parameter: theme.colors.textSecondary.withAlpha(alpha), for: .disabled)
        subtitleColor.set(parameter: theme.colors.textSecondary, for: .normal)
        
        titleFont.set(parameter: theme.fonts.body1, for: .normal, style: nil)
        titleFont.set(parameter: theme.fonts.title1, for: .normal, style: .title)
        titleFont.set(parameter: theme.fonts.subtitle1, for: .normal, style: .body)
        titleFont.set(parameter: theme.fonts.headline, for: .normal, style: .headline)
        
        subtitleFont.set(parameter: theme.fonts.subhead4, for: .normal, style: nil)
        subtitleFont.set(parameter: theme.fonts.body2, for: .normal, style: .title)
        subtitleFont.set(parameter: theme.fonts.body2, for: .normal, style: .body)
        subtitleFont.set(parameter: theme.fonts.subhead4, for: .normal, style: .headline)
    }
}
