//
//  ActionCellViewStyle.swift
//  AdmiralSwiftUI
//
//  Created on 23.06.2021.
//

import AdmiralTheme
import AdmiralUIResources

public struct ActionCellViewScheme: AppThemeScheme {
    
    public var actionBarBackgroundColor = ControlParameter<AColor>()
    
    public init(theme: AppTheme) {
        actionBarBackgroundColor.set(parameter: theme.colors.backgroundAdditionalOne, for: .normal)
    }
}
