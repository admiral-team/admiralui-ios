//
//  GhostButtonStyle.swift
//  AdmiralSwiftUI
//
//  Created on 12.04.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources

@available(iOS 14.0.0, *)
public struct GhostButtonScheme: AppThemeScheme {
    
    public let font: AFont
    public var textColor = ControlParameter<AColor>()
    
    public init(theme: AppTheme) {
        let alpha = theme.colors.disabledAlpha
        
        font = theme.fonts.body1
        
        textColor.set(parameter: theme.colors.textAccent, for: .normal)
        textColor.set(parameter: theme.colors.textAccentPressed, for: .highlighted)
        textColor.set(parameter: theme.colors.textAccent.withAlpha(alpha), for: .disabled)
    }
}
