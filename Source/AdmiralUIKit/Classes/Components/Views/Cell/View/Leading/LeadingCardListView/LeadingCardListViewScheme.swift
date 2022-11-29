//
//  CardListViewScheme.swift
//  AdmiralUI
//
//  Created on 27.11.2020.
//

import UIKit
import AdmiralTheme
import AdmiralUIResources
/**
 ImageCardListViewScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - ImageCardListViewScheme() - Initialize default ImageCardListViewScheme with default themezation
Example to create ImageCardListViewScheme:
Code
 ```
let scheme = ImageCardListViewScheme()
 ```
 */
public struct ImageCardListViewScheme: AppThemeScheme {

    /// Background color.
    public var backgroundColor = ControlParameter<AColor>()

    /// Image view alpha.
    public var imageViewAlpha = ControlParameter<CGFloat>()

    // MARK: - Initializer

    public init(theme: AppTheme = .default) {
        backgroundColor.set(parameter: theme.colors.backgroundSelected, for: .highlighted)
        backgroundColor.set(parameter: theme.colors.backgroundBasic, for: .normal)
        
        imageViewAlpha.set(parameter: 1.0, for: .normal)
        imageViewAlpha.set(parameter: 0.5, for: .disabled)
    }
}
