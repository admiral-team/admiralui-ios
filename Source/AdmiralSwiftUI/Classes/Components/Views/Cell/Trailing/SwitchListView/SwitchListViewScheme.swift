//
//  SwitchListViewStyle.swift
//  AdmiralSwiftUI
//
//  Created on 21.06.2021.
//

import AdmiralTheme
import AdmiralUIResources

@available(iOS 14.0.0, *)
public struct SwitchListViewScheme: AppThemeScheme {
    
    public var backgroundColor = ControlParameter<AColor>()
    public var customSwitch: CustomSwitchScheme
    
    public init(theme: AppTheme) {
        backgroundColor.set(parameter: theme.colors.backgroundSelected, for: .highlighted)
        backgroundColor.set(parameter: theme.colors.backgroundBasic, for: .normal)
        
        customSwitch = CustomSwitchScheme(theme: theme)
    }
}
