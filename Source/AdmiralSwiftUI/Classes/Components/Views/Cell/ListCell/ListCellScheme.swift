//
//  ListCellStyle.swift
//  AdmiralSwiftUI
//
//  Created on 07.06.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources

public struct ListCellScheme: AppThemeScheme {

    // MARK: - Properties

    /// The background color of ListCell
    public var backgroundColor = ControlParameter<AColor>()

    // MARK: - Initializer

    public init(theme: AppTheme) {
        backgroundColor.set(parameter: theme.colors.backgroundSelected, for: .highlighted)
        backgroundColor.set(parameter: theme.colors.backgroundBasic, for: .normal)
    }
}
