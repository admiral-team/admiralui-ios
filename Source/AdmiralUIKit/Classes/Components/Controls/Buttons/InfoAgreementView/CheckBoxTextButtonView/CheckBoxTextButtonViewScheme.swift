//
//  CheckBoxTextButtonViewTheme.swift
//  AdmiralUI
//
//  Created on 11.01.2021.
//

import UIKit
import AdmiralTheme

/**
 CheckBoxTextButtonViewScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - CheckBoxTextButtonViewScheme() - Initialize default CheckBoxTextButtonViewScheme with default themezation
Example to create CheckBoxTextButtonViewScheme:
Code
 ```
let scheme = CheckBoxTextButtonViewScheme()
 ```
 */
public struct CheckBoxTextButtonViewScheme: AppThemeScheme {

    /// Background color
    public var backgroundColor: AColor

    /// Check text control scheme.
    public var checkTextControl = CheckTextControlScheme()

    /// Primary link scheme.
    public var primaryLinkScheme = TagControlCustomScheme()
    
    public init(theme: AppTheme = .default) {
        backgroundColor = theme.colors.backgroundBasic.withAlpha(0.0)
        checkTextControl = CheckTextControlScheme(theme: theme)
        primaryLinkScheme = TagControlCustomScheme(theme: theme)
    }
}
