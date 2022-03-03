//
//  CodeInputControlScheme.swift
//  AdmiralSwiftUI
//
//  Created on 31.08.2021.
//

import AdmiralTheme
import AdmiralUIResources

public struct CodeInputControlScheme: AppThemeScheme {
    
    public var defaultColor: AColor
    public var activeColor: AColor
    public var successColor: AColor
    public var errorColor: AColor
    
    public init(theme: AppTheme) {
        defaultColor = theme.colors.elementAdditional
        activeColor = theme.colors.elementAccent
        successColor = theme.colors.elementSuccess
        errorColor = theme.colors.elementError
    }
}
