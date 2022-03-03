//
//  ButtonListViewStyle.swift
//  AdmiralSwiftUI
//
//  Created on 21.06.2021.
//

import AdmiralTheme
import AdmiralUIResources

@available(iOS 14.0.0, *)
public struct ButtonListViewScheme: AppThemeScheme {
    
    public var backgroundColor = ControlParameter<AColor>()
    
    public var buttonScheme: GhostButtonScheme
    
    public init(theme: AppTheme) {
        backgroundColor.set(parameter: theme.colors.backgroundSelected, for: .highlighted)
        backgroundColor.set(parameter: theme.colors.backgroundBasic, for: .normal)
        
        buttonScheme = GhostButtonScheme(theme: theme)
    }
}
