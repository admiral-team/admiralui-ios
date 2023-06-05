//
//  ImageBackgroundListViewScheme.swift
//  AdmiralUI
//
//  Created on 27.11.2020.
//

import UIKit
import AdmiralTheme

/**
 ImageBackgroundListViewScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - ImageBackgroundListViewScheme() - Initialize default ImageBackgroundListViewScheme with default themezation
Example to create ImageBackgroundListViewScheme:
Code
 ```
let scheme = ImageBackgroundListViewScheme()
 ```
 */
public struct ImageBackgroundListViewScheme: AppThemeScheme {

    /// Background color.
    public var backgroundColor = ControlParameter<AColor>()

    /// Background image view color.
    public var backgroundImageViewColor = ControlParameter<AColor>()

    /// Image tint color.
    public var imageTintColor = ControlParameter<AColor>()
    
    public init(theme: AppTheme = .default) {
        let alpha = theme.colors.disabledAlpha

        backgroundColor.set(parameter: theme.colors.backgroundSelected, for: .highlighted)
        backgroundColor.set(parameter: theme.colors.backgroundBasic, for: .normal)
        
        imageTintColor.set(parameter: theme.colors.elementAccent, for: .normal)
        imageTintColor.set(parameter: theme.colors.elementAccent.withAlpha(alpha), for: .disabled)
        
        backgroundImageViewColor.set(parameter: theme.colors.backgroundAdditionalOne, for: .normal)
    }
}
