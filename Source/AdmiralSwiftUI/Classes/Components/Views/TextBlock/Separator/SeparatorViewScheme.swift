//
//  PaddingViewScheme.swift
//  AdmiralSwiftUI
//
//  Created on 28.09.2021.
//

import AdmiralTheme
import AdmiralUIResources

public struct SeparatorViewScheme: AppThemeScheme {

    // MARK: - Public Properties

    /// The line color of SeparatorView
    public var lineTintColor: AColor

    // MARK: - Initializer

    public init(theme: AppTheme) {
        lineTintColor = theme.colors.elementAdditional
    }
}
