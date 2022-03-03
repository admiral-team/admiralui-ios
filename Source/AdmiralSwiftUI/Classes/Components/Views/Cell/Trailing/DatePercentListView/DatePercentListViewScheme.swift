//
//  DatePercentListViewStyle.swift
//  AdmiralSwiftUI
//
//  Created on 21.06.2021.
//

import AdmiralTheme
import AdmiralUIResources

public struct DatePercentListViewScheme: AppThemeScheme {
    
    public var backgroundColor = ControlParameter<AColor>()
    public var titleColor = ControlParameter<AColor>()
    public var subtitleColor = ControlParameter<AColor>()
    
    public var titleFont: AFont
    public var subtitleFont: AFont
    
    public init(theme: AppTheme) {
        let alpha = theme.colors.disabledAlpha

        backgroundColor.set(parameter: theme.colors.backgroundSelected, for: .highlighted)
        backgroundColor.set(parameter: theme.colors.backgroundBasic, for: .normal)
        
        titleColor.set(parameter: theme.colors.textSecondary.withAlpha(alpha), for: .disabled)
        titleColor.set(parameter: theme.colors.textSecondary, for: .normal)
        
        subtitleColor.set(parameter: theme.colors.textSecondary.withAlpha(alpha), for: .disabled)
        subtitleColor.set(parameter: theme.colors.textSecondary, for: .normal)
        
        titleFont = theme.fonts.subhead3
        subtitleFont = theme.fonts.subhead3
    }
}
