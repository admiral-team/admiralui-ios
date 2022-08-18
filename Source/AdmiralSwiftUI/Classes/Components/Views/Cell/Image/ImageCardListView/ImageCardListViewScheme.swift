//
//  ImageCardListViewStyle.swift
//  AdmiralSwiftUI
//
//  Created on 22.06.2021.
//

import AdmiralTheme
import AdmiralUIResources

public struct ImageCardListViewScheme: AppThemeScheme {

    // MARK: - Properties

    /// The background color of ImageCardListView
    public var backgroundColor = ControlParameter<AColor>()

    /// The image tint color of ImageCardListView
    public var imageTintColor = ControlParameter<AColor>()

    /// The image alpha of ImageCardListView
    public var imageViewAlpha = ControlParameter<Double>()

    // MARK: - Initializer

    public init(theme: AppTheme) {
        let alpha = theme.colors.disabledAlpha

        backgroundColor.set(parameter: theme.colors.backgroundSelected, for: .highlighted)
        backgroundColor.set(parameter: theme.colors.backgroundBasic, for: .normal)

        imageTintColor.set(parameter: theme.colors.elementAccent.withAlpha(alpha), for: .disabled)
        imageTintColor.set(parameter: theme.colors.elementAccent, for: .normal)
        
        imageViewAlpha.set(parameter: 1.0, for: .normal)
        imageViewAlpha.set(parameter: Double(alpha), for: .disabled)
    }
}
