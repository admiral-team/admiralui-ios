//
//  CardListViewStyle.swift
//  AdmiralSwiftUI
//
//  Created on 21.06.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources
/**
 CardListViewScheme - the visual scheme of CardListView.
 You can create a by specifying the following parameters in init:
 - CardListViewScheme() - Initialize default CardListViewScheme with default themezation
 # Example to create CardListViewScheme:
 # Code
 ```
 let scheme = CardListViewScheme()
 ```
 */
@available(iOS 14.0, *)
public struct CardListViewScheme: AppThemeScheme {

    // MARK: - Public Properties

    /// The  parameter that sets view background color with state
    public var backgroundColor = ControlParameter<AColor>()

    /// The  parameter that sets image tint color with state
    public var imageTintColor = ControlParameter<AColor>()

    /// The  parameter that sets image view alpha with state
    public var imageViewAlpha = ControlParameter<Double>()

    // MARK: - Initializer

    public init(theme: AppTheme = .default) {
        let alpha = theme.colors.disabledAlpha

        backgroundColor.set(parameter: theme.colors.backgroundSelected, for: .highlighted)
        backgroundColor.set(parameter: theme.colors.backgroundBasic, for: .normal)

        imageTintColor.set(parameter: theme.colors.elementPrimary.withAlpha(alpha), for: .disabled)
        imageTintColor.set(parameter: theme.colors.elementPrimary, for: .normal)
        
        imageViewAlpha.set(parameter: 1.0, for: .normal)
        imageViewAlpha.set(parameter: 0.5, for: .disabled)
    }
}
