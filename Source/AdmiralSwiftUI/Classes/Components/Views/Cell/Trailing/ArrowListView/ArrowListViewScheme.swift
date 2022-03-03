//
//  ArrowListViewStyle.swift
//  AdmiralSwiftUI
//
//  Created on 07.06.2021.
//

import UIKit
import AdmiralTheme
import AdmiralUIResources

public struct ArrowListViewScheme: AppThemeScheme {
    
    public var backgroundColor = ControlParameter<AColor>()
    public var imageTintColor = ControlParameter<AColor>()
    
    public init(theme: AppTheme) {
        let alpha = theme.colors.disabledAlpha

        backgroundColor.set(parameter: theme.colors.backgroundSelected, for: .highlighted)
        backgroundColor.set(parameter: theme.colors.backgroundBasic, for: .normal)

        imageTintColor.set(parameter: theme.colors.elementPrimary.withAlpha(alpha), for: .disabled)
        imageTintColor.set(parameter: theme.colors.textSecondary, for: .normal)
    }
}
