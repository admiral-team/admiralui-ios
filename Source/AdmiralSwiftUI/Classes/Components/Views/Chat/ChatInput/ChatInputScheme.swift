//
//  ChatInputScheme.swift
//  AdmiralSwiftUI
//
//  Created on 16.08.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources

public struct ChatInputScheme: AppThemeScheme {
    
    public var textColor: AColor
    public var placeholderColor: AColor
    public var backgroundColor = ControlParameter<AColor>()
    public var tintColor: AColor
    public var textFont: AFont
    public var placeholderFont: AFont
    public var imageTintColor: AColor
    
    public init(theme: AppTheme) {
        let alpha = theme.colors.disabledAlpha
        textColor = theme.colors.textPrimary
        placeholderColor = theme.colors.textSecondary
        backgroundColor.set(parameter: theme.colors.backgroundAdditionalOne.withAlpha(alpha), for: .disabled)
        backgroundColor.set(parameter: theme.colors.backgroundAdditionalOne, for: .normal)
        backgroundColor.set(parameter: theme.colors.backgroundAdditionalOne, for: .selected)
        backgroundColor.set(parameter: theme.colors.backgroundAdditionalOne, for: .highlighted)

        tintColor = theme.colors.elementAccent
        imageTintColor = theme.colors.elementPrimary
        
        textFont = theme.fonts.body2
        placeholderFont = theme.fonts.body2
    }
    
}
