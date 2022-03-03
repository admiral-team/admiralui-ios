//
//  StandardTextFieldStyle.swift
//  AdmiralSwiftUI
//
//  Created on 20.05.2021.
//

import SwiftUI
import Combine
import AdmiralTheme
import AdmiralUIResources

public struct StandardTextFieldScheme: AppThemeScheme {
    
    public var tintColor: AColor
    public var textColor: AColor
    public var errorColor: AColor
    public var disabledColor: AColor
    public var underlineColor: AColor
    public var placeholderColor = ControlParameter<AColor>()
    
    public var textFieldFont: AFont
    public var informerFont: AFont
    public var nameFont: AFont
    
    public init(theme: AppTheme) {
        let alpha = theme.colors.disabledAlpha

        tintColor = theme.colors.elementAccent
        textColor = theme.colors.textPrimary
        errorColor = theme.colors.textError
        disabledColor = theme.colors.textSecondary.withAlpha(alpha)
        underlineColor = theme.colors.textSecondary
        
        placeholderColor.set(parameter: theme.colors.textSecondary, for: .normal)
        placeholderColor.set(parameter: theme.colors.textSecondary.withAlpha(alpha), for: .disabled)

        textFieldFont = theme.fonts.body1
        informerFont = theme.fonts.subhead3
        nameFont = theme.fonts.subhead3
    }
    
}
