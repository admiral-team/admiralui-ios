//
//  RadioButtonListViewStyle.swift
//  AdmiralSwiftUI
//
//  Created on 18.06.2021.
//

import AdmiralTheme
import AdmiralUIResources

@available(iOS 14.0.0, *)
public struct RadioButtonListViewScheme: AppThemeScheme {
    
    public var backgroundColor = ControlParameter<AColor>()
    public var radioButtonView: CheckControlScheme
    
    public init(theme: AppTheme) {
        backgroundColor.set(parameter: theme.colors.backgroundSelected, for: .highlighted)
        backgroundColor.set(parameter: theme.colors.backgroundBasic, for: .normal)
        
        radioButtonView = CheckControlScheme(theme: theme)
    }
}
