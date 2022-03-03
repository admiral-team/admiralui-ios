//
//  ImageWithSubtitleListViewStyle.swift
//  AdmiralSwiftUI
//
//  Created on 21.06.2021.
//

import AdmiralTheme
import AdmiralUIResources

public struct ImageWithSubtitleListViewScheme: AppThemeScheme {
    
    public var backgroundColor = ControlParameter<AColor>()
    public var imageTintColor = ControlParameter<AColor>()
    public var imageViewAlpha = ControlParameter<Double>()
    public var subtitleLabelTextColor = ControlParameter<AColor>()
    
    public var subtitleFont: AFont

    public init(theme: AppTheme) {
        let alpha = theme.colors.disabledAlpha
        
        backgroundColor.set(parameter: theme.colors.backgroundSelected, for: .highlighted)
        backgroundColor.set(parameter: theme.colors.backgroundBasic, for: .normal)
        
        imageTintColor.set(parameter: theme.colors.elementAccent, for: .normal)
        imageTintColor.set(parameter: theme.colors.elementAccent, for: .disabled)
        
        imageViewAlpha.set(parameter: 1.0, for: .normal)
        imageViewAlpha.set(parameter: 0.5, for: .disabled)
        
        subtitleLabelTextColor.set(parameter: theme.colors.textSecondary, for: .normal)
        subtitleLabelTextColor.set(parameter: theme.colors.textSecondary.withAlpha(alpha), for: .disabled)
        
        subtitleFont = theme.fonts.subhead3
    }
}
