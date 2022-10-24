//
//  ButtonDropDownScheme.swift
//  AdmiralUIKit
//
//  Created on 24.02.2022.
//

import AdmiralTheme
import AdmiralUIResources
import UIKit

/**
 ButtonDropDownScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - ButtonDropDownScheme() - Initialize default ButtonDropDownScheme with default themezation
Example to create ButtonDropDownScheme:
Code
 ```
let scheme = ButtonDropDownScheme()
 ```
 */
public struct ButtonDropDownScheme: AppThemeScheme {

    /// Background color.
    public var backgroundColor: AColor

    /// Ghost button scheme.
    public var ghostButtonScheme: HeaderButtonWithArrowScheme

    public init(theme: AppTheme = .default) {
        backgroundColor = theme.colors.backgroundBasic
        
        ghostButtonScheme = HeaderButtonWithArrowScheme(theme: theme)
    }
}
