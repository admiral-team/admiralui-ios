//
//  LinePageControllScheme.swift
//  AdmiralSwiftUI
//
//  Created on 31.05.2022.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources

@available(iOS 14.0.0, *)
public struct PageControlViewScheme: AppThemeScheme {
            
    public var backgroundColor = ControlParameter<AColor>()
    
    public init() {
        self.init(theme: AppTheme.default)
    }
    
    public init(theme: AppTheme) {
        backgroundColor.set(parameter: theme.colors.textSecondary, for: .normal)
        backgroundColor.set(parameter: theme.colors.textPrimary, for: .selected)
    }
    
}
