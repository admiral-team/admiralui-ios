//
//  DoubleTextFieldStyle.swift
//  AdmiralSwiftUI
//
//  Created on 02.06.2021.
//

import AdmiralTheme
import AdmiralUIResources

public struct DoubleTextFieldScheme: AppThemeScheme {
    
    public var errorColor: AColor
    public var underlineColor: AColor
    public var disabledColor: AColor
    
    public var informerFont: AFont
    
    public init(theme: AppTheme) {
        let alpha = theme.colors.disabledAlpha

        self.informerFont = theme.fonts.subhead3
        
        self.errorColor = theme.colors.textError
        self.underlineColor = theme.colors.textSecondary
        self.disabledColor = theme.colors.textSecondary.withAlpha(alpha)
    }
}
