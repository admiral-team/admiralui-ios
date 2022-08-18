//
//  ImageBackgroundListViewStyle.swift
//  AdmiralSwiftUI
//
//  Created on 22.06.2021.
//

import AdmiralTheme
import AdmiralUIResources

public struct ImageBackgroundListViewScheme: AppThemeScheme {

    // MARK: - Properties

    /// The background color of ImageBackgroundListView
    public var backgroundColor = ControlParameter<AColor>()

    /// The background image view color of ImageBackgroundListView
    public var backgroundImageViewColor = ControlParameter<AColor>()

    /// The image tint color of ImageBackgroundListView
    public var imageTintColor = ControlParameter<AColor>()

    /// The image view alpha  of ImageBackgroundListView
    public var imageViewAlpha = ControlParameter<Double>()

    // MARK: - Initializer

    public init(theme: AppTheme) {
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
