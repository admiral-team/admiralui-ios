//
//  SliderStyle.swift
//  AdmiralSwiftUI
//
//  Created on 27.05.2021.
//

import AdmiralTheme
import AdmiralUIResources

public struct SliderScheme: AppThemeScheme {
    public var tintColor = ControlParameter<AColor>()
    public var thumbColor = ControlParameter<AColor>()
    public var thumbBorderColor = ControlParameter<AColor>()
    public var backgroundColor = ControlParameter<AColor>()
    
    public init() {
        self.init(theme: AppTheme.default)
    }
    
    public init(theme: AppTheme) {
        let alpha = theme.colors.disabledAlpha

        tintColor.set(parameter: theme.colors.backgroundAccent, for: .normal)
        thumbColor.set(parameter: theme.colors.backgroundBasic, for: .normal)
        backgroundColor.set(parameter: theme.colors.elementPrimary, for: .normal)
        thumbBorderColor.set(parameter: theme.colors.backgroundAccent, for: .normal)
        
        tintColor.set(parameter: theme.colors.elementPrimary, for: .disabled)
        thumbColor.set(parameter: theme.colors.backgroundBasic, for: .disabled)
        backgroundColor.set(parameter: theme.colors.elementPrimary.withAlpha(alpha), for: .disabled)
        thumbBorderColor.set(parameter: theme.colors.elementPrimary, for: .disabled)
    }
}
