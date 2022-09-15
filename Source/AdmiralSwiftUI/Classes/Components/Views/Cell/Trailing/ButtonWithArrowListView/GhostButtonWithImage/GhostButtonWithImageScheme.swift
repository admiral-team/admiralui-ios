//
//  GhostButtonWithImageStyle.swift
//  AdmiralSwiftUI
//
//  Created on 21.06.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources

public struct GhostButtonWithImageScheme: AppThemeScheme {
    
    public let font: AFont
    public var textColor = ControlParameter<AColor>()
    public var imageColor = ControlParameter<AColor>()
    
    public init(theme: AppTheme) {
        let alpha = theme.colors.disabledAlpha
        
        font = theme.fonts.body1
        
        textColor.set(parameter: theme.colors.textAccent, for: .normal)
        textColor.set(parameter: theme.colors.textAccentPressed, for: .highlighted)
        textColor.set(parameter: theme.colors.textAccent.withAlpha(alpha), for: .disabled)

        imageColor.set(parameter: theme.colors.elementAccent, for: .normal)
        imageColor.set(parameter: theme.colors.elementAccentPressed, for: .highlighted)
        imageColor.set(parameter: theme.colors.elementAccent.withAlpha(alpha), for: .disabled)
    }
}
