//
//  ListCellStyle.swift
//  AdmiralSwiftUI
//
//  Created on 07.06.2021.
//
import AdmiralCore
import AdmiralTheme
import AdmiralUIResources
/**
 ListCellScheme - the visual scheme of ListCell.
 You can create a by specifying the following parameters in init:
 - ListCellScheme() - Initialize default ListCellScheme with default themezation
 # Example to create ListCellScheme:
 # Code
 ```
 let scheme = ListCellScheme()
 ```
 */
@available(iOS 14.0.0, *)
public struct ListCellScheme: AppThemeScheme {

    // MARK: - Public Properties

    /// The parameter that sets background color with state
    public var backgroundColor = ControlParameter<AColor>()

    // MARK: - Initializer

    public init(theme: AppTheme = .default) {
        backgroundColor.set(parameter: theme.colors.backgroundSelected, for: .highlighted)
        backgroundColor.set(parameter: theme.colors.backgroundBasic, for: .normal)
    }
}
