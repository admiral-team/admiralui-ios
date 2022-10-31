//
//  ArrowListViewScheme.swift
//  AdmiralUI
//
//  Created on 27.11.2020.
//

import UIKit
import AdmiralTheme
import AdmiralUIResources

/**
 ArrowListViewScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - ArrowListViewScheme() - Initialize default ArrowListViewScheme with default themezation
Example to create ArrowListViewScheme:
Code
 ```
let scheme = ArrowListViewScheme()
 ```
 */
public struct ArrowListViewScheme: AppThemeScheme {

    /// Background color.
    public var backgroundColor = ControlParameter<AColor>()

    /// Image tint color.
    public var imageTintColor = ControlParameter<AColor>()
    
    public init(theme: AppTheme = .default) {
        let alpha = theme.colors.disabledAlpha

        backgroundColor.set(parameter: theme.colors.backgroundSelected, for: .highlighted)
        backgroundColor.set(parameter: theme.colors.backgroundBasic, for: .normal)

        imageTintColor.set(parameter: theme.colors.elementPrimary.withAlpha(alpha), for: .disabled)
        imageTintColor.set(parameter: theme.colors.textSecondary, for: .normal)
    }
}
