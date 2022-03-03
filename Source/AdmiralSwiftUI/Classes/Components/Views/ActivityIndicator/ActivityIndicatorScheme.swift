//
//  ActivityIndicatorScheme.swift
//  AdmiralSwiftUI
//
//  Created on 02.09.2021.
//

import AdmiralTheme
import AdmiralUIResources

public struct ActivityIndicatorScheme: AppThemeScheme {
    
    public var backgroundDefaultColor = ControlParameter<AColor>()
    public var backgroundConstrastColor = ControlParameter<AColor>()
    
    public init(theme: AppTheme) {
        let alpha = theme.colors.disabledAlpha
        
        backgroundDefaultColor.set(parameter: theme.colors.elementStaticWhite, for: .normal)
        backgroundDefaultColor.set(parameter: theme.colors.elementStaticWhite.withAlpha(alpha), for: .disabled)
        
        backgroundConstrastColor.set(parameter: theme.colors.elementAccent, for: .normal)
        backgroundConstrastColor.set(parameter: theme.colors.elementAccent.withAlpha(alpha), for: .disabled)
    }
    
}
