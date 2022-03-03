//
//  ImageCardListViewStyle.swift
//  AdmiralSwiftUI
//
//  Created on 22.06.2021.
//

import AdmiralTheme
import AdmiralUIResources

public struct ImageCardListViewScheme: AppThemeScheme {
    
    public var backgroundColor = ControlParameter<AColor>()
    public var imageTintColor = ControlParameter<AColor>()
    public var imageViewAlpha = ControlParameter<Double>()
    
    public init(theme: AppTheme) {
        let alpha = theme.colors.disabledAlpha

        backgroundColor.set(parameter: theme.colors.backgroundSelected, for: .highlighted)
        backgroundColor.set(parameter: theme.colors.backgroundBasic, for: .normal)

        imageTintColor.set(parameter: theme.colors.elementAccent.withAlpha(alpha), for: .disabled)
        imageTintColor.set(parameter: theme.colors.elementAccent, for: .normal)
        
        imageViewAlpha.set(parameter: 1.0, for: .normal)
        imageViewAlpha.set(parameter: Double(alpha), for: .disabled)
    }
}
