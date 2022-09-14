//
//  ArrowListViewStyle.swift
//  AdmiralSwiftUI
//
//  Created on 07.06.2021.
//

import UIKit
import AdmiralTheme
import AdmiralUIResources
/**
 ArrowListViewScheme - the visual scheme of ArrowListView.
 You can create a by specifying the following parameters in init:
 - ArrowListViewScheme() - Initialize default ArrowListViewScheme with default themezation
 # Example to create ArrowListViewScheme:
 # Code
 ```
 let scheme = ArrowListViewScheme()
 ```
 */
@available(iOS 14.0, *)
public struct ArrowListViewScheme: AppThemeScheme {

    // MARK: - Public Properties

    /// The  parameter that sets view background color with state
    public var backgroundColor = ControlParameter<AColor>()

    /// The  parameter that sets image tint color with state
    public var imageTintColor = ControlParameter<AColor>()

    // MARK: - Initializer

    public init(theme: AppTheme = .default) {
        let alpha = theme.colors.disabledAlpha

        backgroundColor.set(parameter: theme.colors.backgroundSelected, for: .highlighted)
        backgroundColor.set(parameter: theme.colors.backgroundBasic, for: .normal)

        imageTintColor.set(parameter: theme.colors.elementPrimary.withAlpha(alpha), for: .disabled)
        imageTintColor.set(parameter: theme.colors.textSecondary, for: .normal)
    }
}
