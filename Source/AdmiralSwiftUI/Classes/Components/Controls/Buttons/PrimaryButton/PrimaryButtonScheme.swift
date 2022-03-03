//
//  PrimaryButtonSheme.swift
//  AdmiralSwiftUI
//
//  Created on 09.04.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources

@available(iOS 14.0.0, *)
public struct PrimaryButtonScheme: AppThemeScheme {
    
    public let font: AFont
    public var backgroundColor: AColor
    public var buttonBackgroundColor = ControlParameter<AColor>()
    public var textColor = ControlParameter<AColor>()
    
    public init(theme: AppTheme) {
        let alpha = theme.colors.disabledAlpha
        
        font = theme.fonts.body1
        
        backgroundColor = theme.colors.backgroundBasic
        
        buttonBackgroundColor.set(parameter: theme.colors.backgroundAccent, for: .normal)
        buttonBackgroundColor.set(parameter: theme.colors.backgroundAccentPressed, for: .highlighted)
        buttonBackgroundColor.set(parameter: theme.colors.backgroundAccent.withAlpha(alpha), for: .disabled)
        
        textColor.set(parameter: theme.colors.textStaticWhite, for: .normal)
        textColor.set(parameter: theme.colors.textStaticWhite.withAlpha(alpha), for: .disabled)
    }
    
}
