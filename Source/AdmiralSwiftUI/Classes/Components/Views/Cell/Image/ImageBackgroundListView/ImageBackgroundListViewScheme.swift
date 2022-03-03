//
//  ImageBackgroundListViewStyle.swift
//  AdmiralSwiftUI
//
//  Created on 22.06.2021.
//

import AdmiralTheme
import AdmiralUIResources

public struct ImageBackgroundListViewScheme: AppThemeScheme {
    
    public var backgroundColor = ControlParameter<AColor>()
    public var backgroundImageViewColor = ControlParameter<AColor>()
    public var imageTintColor = ControlParameter<AColor>()
    public var imageViewAlpha = ControlParameter<Double>()
    
    public init(theme: AppTheme) {
        let alpha = theme.colors.disabledAlpha

        backgroundColor.set(parameter: theme.colors.backgroundSelected, for: .highlighted)
        backgroundColor.set(parameter: theme.colors.backgroundBasic, for: .normal)
        
        imageTintColor.set(parameter: theme.colors.elementAccent, for: .normal)
        imageTintColor.set(parameter: theme.colors.elementAccent.withAlpha(alpha), for: .disabled)
        
        imageViewAlpha.set(parameter: 1.0, for: .normal)
        imageViewAlpha.set(parameter: Double(alpha), for: .disabled)
        
        backgroundImageViewColor.set(parameter: theme.colors.backgroundAdditionalOne, for: .normal)
    }
}
