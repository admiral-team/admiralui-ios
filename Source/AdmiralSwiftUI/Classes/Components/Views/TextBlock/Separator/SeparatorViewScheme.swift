//
//  PaddingViewScheme.swift
//  AdmiralSwiftUI
//
//  Created on 28.09.2021.
//

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
public struct SeparatorViewScheme: AppThemeScheme {

    // MARK: - Public Properties

    public var lineTintColor: AColor

    // MARK: - Initializer

    public init(theme: AppTheme = .default) {
        lineTintColor = theme.colors.elementAdditional
    }

}

