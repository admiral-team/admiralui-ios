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
struct PageControlViewScheme: AppThemeScheme {
            
    var backgroundColor = ControlParameter<AColor>()
    
    public init() {
        self.init(theme: AppTheme.default)
    }
    
    init(theme: AppTheme) {
        backgroundColor.set(parameter: theme.colors.textSecondary, for: .normal)
        backgroundColor.set(parameter: theme.colors.textPrimary, for: .selected)
    }
    
}
