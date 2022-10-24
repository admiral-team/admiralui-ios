//
//  ImageListViewScheme.swift
//  AdmiralUI
//
//  Created on 27.11.2020.
//

import UIKit
import AdmiralTheme
import AdmiralUIResources

/**
 ImageListViewScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - ImageListViewScheme() - Initialize default ImageListViewScheme with default themezation
Example to create ImageListViewScheme:
Code
 ```
let scheme = ImageListViewScheme()
 ```
 */
public struct ImageListViewScheme: AppThemeScheme {

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

        imageTintColor.set(parameter: theme.colors.elementAccent.withAlpha(alpha), for: .disabled)
        imageTintColor.set(parameter: theme.colors.elementAccent, for: .normal)
        
        imageViewAlpha.set(parameter: 1.0, for: .normal)
        imageViewAlpha.set(parameter: alpha, for: .disabled)
    }
}
