//
//  IconListViewScheme.swift
//  AdmiralUI
//
//  Created on 27.11.2020.
//

import UIKit
import AdmiralTheme

/**
 IconListViewScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - IconListViewScheme() - Initialize default IconListViewScheme with default themezation
Example to create IconListViewScheme:
Code
 ```
let scheme = IconListViewScheme()
 ```
 */
public struct IconListViewScheme: AppThemeScheme {

    /// Background color.
    public var backgroundColor = ControlParameter<AColor>()

    /// Image tint color.
    public var imageTintColor = ControlParameter<AColor>()

    /// Image view alpha.
    public var imageViewAlpha = ControlParameter<CGFloat>()
    
    public init(theme: AppTheme = .default) {
        let alpha = theme.colors.disabledAlpha

        backgroundColor.set(parameter: theme.colors.backgroundSelected, for: .highlighted)
        backgroundColor.set(parameter: theme.colors.backgroundBasic, for: .normal)

        imageTintColor.set(parameter: theme.colors.elementPrimary.withAlpha(alpha), for: .disabled)
        imageTintColor.set(parameter: theme.colors.textSecondary, for: .normal)
        
        imageViewAlpha.set(parameter: 1.0, for: .normal)
        imageViewAlpha.set(parameter: 0.5, for: .disabled)
    }
}
