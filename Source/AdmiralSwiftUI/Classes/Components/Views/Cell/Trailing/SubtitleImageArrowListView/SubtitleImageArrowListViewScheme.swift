//
//  SubtitleImageArrowListViewScheme.swift
//  AdmiralSwiftUI
//
//  Created on 22.11.2021.
//

import AdmiralTheme
import AdmiralUIResources

public struct SubtitleImageArrowListViewScheme: AppThemeScheme {
    
    public var backgroundColor = ControlParameter<AColor>()
    public var imageTintColor = ControlParameter<AColor>()
    public var imageViewAlpha = ControlParameter<Double>()
    public var subtitleLabelTextColor = ControlParameter<AColor>()
    public var arrowTintColor = ControlParameter<AColor>()
    
    public var subtitleFont: AFont
    
    public init(theme: AppTheme) {
        let alpha = theme.colors.disabledAlpha
        
        backgroundColor.set(parameter: theme.colors.backgroundSelected, for: .highlighted)
        backgroundColor.set(parameter: theme.colors.backgroundBasic, for: .normal)
        
        imageTintColor.set(parameter: theme.colors.elementPrimary, for: .normal)
        imageTintColor.set(parameter: theme.colors.elementPrimary.withAlpha(alpha), for: .disabled)
        
        imageViewAlpha.set(parameter: 1.0, for: .normal)
        imageViewAlpha.set(parameter: 0.5, for: .disabled)
        
        subtitleLabelTextColor.set(parameter: theme.colors.textSecondary, for: .normal)
        subtitleLabelTextColor.set(parameter: theme.colors.textSecondary.withAlpha(alpha), for: .disabled)
        
        arrowTintColor.set(parameter: theme.colors.elementPrimary.withAlpha(alpha), for: .disabled)
        arrowTintColor.set(parameter: theme.colors.textSecondary, for: .normal)
        
        subtitleFont = theme.fonts.subhead3
    }
}


