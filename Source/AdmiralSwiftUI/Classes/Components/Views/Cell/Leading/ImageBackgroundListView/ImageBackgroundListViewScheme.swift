//
//  ImageBackgroundListViewStyle.swift
//  AdmiralSwiftUI
//
//  Created on 22.06.2021.
//

import AdmiralTheme
/**
 ImageNameListViewScheme - the visual scheme of ImageNameListView.
 You can create a by specifying the following parameters in init:
 - ImageNameListViewScheme() - Initialize default ImageNameListViewScheme with default themezation
 # Example to create ImageNameListViewScheme:
 # Code
 ```
 let scheme = ImageNameListViewScheme()
 ```
 */
public struct ImageBackgroundListViewScheme: AppThemeScheme {

    // MARK: - Public Properties

    public var backgroundColor = ControlParameter<AColor>()
    public var backgroundImageViewColor = ControlParameter<AColor>()
    public var imageTintColor = ControlParameter<AColor>()
    public var imageViewAlpha = ControlParameter<Double>()

    // MARK: - Initializer

    public init(theme: AppTheme = .default) {
        let alpha = theme.colors.disabledAlpha

        backgroundColor.set(parameter: theme.colors.backgroundSelected, for: .highlighted)
        backgroundColor.set(parameter: theme.colors.backgroundBasic, for: .normal)
        
        imageTintColor.set(parameter: theme.colors.elementAccent, for: .normal)
        imageTintColor.set(parameter: theme.colors.elementAccent.withAlpha(alpha), for: .disabled)
        
        imageViewAlpha.set(parameter: 1.0, for: .normal)
        imageViewAlpha.set(parameter: Double(alpha), for: .disabled)
        
        backgroundImageViewColor.set(parameter: theme.colors.backgroundAdditionalOne, for: .normal)
    }
}
