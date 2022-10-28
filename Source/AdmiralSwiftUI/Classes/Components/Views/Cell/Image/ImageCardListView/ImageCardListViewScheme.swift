//
//  ImageCardListViewStyle.swift
//  AdmiralSwiftUI
//
//  Created on 22.06.2021.
//

import AdmiralTheme
import AdmiralUIResources
/**
 ImageCardListViewScheme - the visual scheme of ImageCardListView.
 You can create a by specifying the following parameters in init:
 - ImageCardListViewScheme() - Initialize default ImageCardListViewScheme with default themezation
 # Example to create ImageCardListViewScheme:
 # Code
 ```
 let scheme = ImageCardListViewScheme()
 ```
 */
public struct ImageCardListViewScheme: AppThemeScheme {

    // MARK: - Public Properties

    /// The background color
    public var backgroundColor = ControlParameter<AColor>()

    /// The image tint color
    public var imageTintColor = ControlParameter<AColor>()

    /// The control parameter that sets alpha
    public var imageViewAlpha = ControlParameter<Double>()

    // MARK: - Initializer

    public init(theme: AppTheme = .default) {
        let alpha = theme.colors.disabledAlpha

        backgroundColor.set(parameter: theme.colors.backgroundSelected, for: .highlighted)
        backgroundColor.set(parameter: theme.colors.backgroundBasic, for: .normal)

        imageTintColor.set(parameter: theme.colors.elementAccent.withAlpha(alpha), for: .disabled)
        imageTintColor.set(parameter: theme.colors.elementAccent, for: .normal)
        
        imageViewAlpha.set(parameter: 1.0, for: .normal)
        imageViewAlpha.set(parameter: Double(alpha), for: .disabled)
    }
}