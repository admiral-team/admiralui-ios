//
//  FeedbackInputControlStyle.swift
//  AdmiralSwiftUI
//
//  Created on 31.05.2021.
//

import AdmiralTheme
import AdmiralUIResources

public struct FeedbackInputControlScheme: AppThemeScheme {
    
    public var defaultColor = ControlParameter<AColor>()
    public var selectedColor = ControlParameter<AColor>()
    
    public init(theme: AppTheme) {
        let alpha = theme.colors.disabledAlpha

        defaultColor.set(parameter: theme.colors.elementAdditional, for: .normal)
        selectedColor.set(parameter: theme.colors.elementAccent, for: .normal)
        
        defaultColor.set(parameter: theme.colors.elementAdditional.withAlpha(alpha), for: .disabled)
        selectedColor.set(parameter: theme.colors.elementAccent.withAlpha(alpha), for: .disabled)
    }
}
