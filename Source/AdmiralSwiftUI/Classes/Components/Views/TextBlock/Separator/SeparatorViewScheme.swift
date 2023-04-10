//
//  PaddingViewScheme.swift
//  AdmiralSwiftUI
//
//  Created on 28.09.2021.
//

import AdmiralCore
import AdmiralTheme
import AdmiralUIResources
/**
 SeparatorViewScheme - the visual scheme of SeparatorView.
 You can create a by specifying the following parameters in init:
 - SeparatorViewScheme() - Initialize default SeparatorViewScheme with default themezation
 # Example to create SeparatorViewScheme:
 # Code
 ```
 let scheme = SeparatorViewScheme()
 ```
 */
@available(iOS 14.0.0, *)
public struct SeparatorViewScheme: AppThemeScheme {

    // MARK: - Public Properties

    /// The line tint color
    public var lineTintColor: AColor

    /// List cell scheme.
    public var listCellScheme: ListCellScheme

    // MARK: - Initializer

    public init(theme: AppTheme = .default) {
        lineTintColor = theme.colors.elementAdditional
        listCellScheme = ListCellScheme(theme: theme)
    }

}
