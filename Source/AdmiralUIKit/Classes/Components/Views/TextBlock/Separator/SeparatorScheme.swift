//
//  SeparatorScheme.swift
//  AdmiralUIKit
//
//  Created on 12.07.2022.
//

import AdmiralCore
import AdmiralTheme
import AdmiralUIResources
import UIKit

/**
 SeparatorScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - SeparatorScheme() - Initialize default SeparatorScheme with default themezation
Example to create SeparatorScheme:
Code
 ```
let scheme = SeparatorScheme()
 ```
 */
public struct SeparatorScheme: AppThemeScheme {

    /// Background color.
    public var backgroundColor: AColor

    /// Separator color.
    public var separatorColor: AColor
    
    public init(theme: AppTheme = .default) {
        backgroundColor = theme.colors.backgroundBasic
        separatorColor = theme.colors.elementAdditional
    }
}
