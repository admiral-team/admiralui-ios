//
//  PageControlViewScheme.swift
//  AdmiralUI
//
//  Created on 23.12.2020.
//

import UIKit
import AdmiralTheme

/**
 PageControlViewScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - PageControlViewScheme() - Initialize default PageControlViewScheme with default themezation
Example to create PageControlViewScheme:
Code
 ```
let scheme = PageControlViewScheme()
 ```
 */
public struct PageControlViewScheme: AppThemeScheme {

    /// Background color.
    public var backgroundColor = ControlParameter<AColor>()

    public init(theme: AppTheme = .default) {
        backgroundColor.set(parameter: theme.colors.textSecondary, for: .normal)
        backgroundColor.set(parameter: theme.colors.textPrimary, for: .selected)
    }
    
}
