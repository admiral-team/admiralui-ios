//
//  SeveralPinButtonScheme.swift
//  AdmiralSwiftUI
//
//  Created on 15.08.2021.
//

import AdmiralTheme
import AdmiralUIResources

@available(iOS 14.0.0, *)
public struct SeveralPinButtonScheme: AppThemeScheme {
    
    public var borderColor: AColor
    public var backgroundColor: AColor
    public var textColor: AColor
    public let shadowColor: AColor
    
    public init() {
        self.init(theme: AppTheme.default)
    }
    
    public init(theme: AppTheme) {
        textColor = theme.colors.textPrimary
        backgroundColor = theme.colors.backgroundBasic
        borderColor = theme.colors.backgroundAccent
        shadowColor = theme.colors.backgroundShadow
    }
    
}
