//
//  ImageCardListViewStyle.swift
//  AdmiralSwiftUI
//
//  Created on 22.06.2021.
//

import AdmiralCore
import AdmiralTheme
import AdmiralUIResources
/**
 LeadingCardListViewScheme - the visual scheme of LeadingCardListView.
 You can create a by specifying the following parameters in init:
 - LeadingCardListViewScheme() - Initialize default LeadingCardListViewScheme with default themezation
 # Example to create LeadingCardListViewScheme:
 # Code
 ```
 let scheme = LeadingCardListViewScheme()
 ```
 */
public struct LeadingCardListViewScheme: AppThemeScheme {

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
