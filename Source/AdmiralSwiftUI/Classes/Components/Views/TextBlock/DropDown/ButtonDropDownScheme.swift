//
//  ButtonDropDownScheme.swift
//  AdmiralSwiftUI
//
//  Created by ADyatkov on 17.09.2022.
//

import AdmiralTheme
import AdmiralUIResources
/**
 ButtonDropDownScheme - the visual scheme of ButtonDropDown.
 You can create a by specifying the following parameters in init:
 - ButtonDropDownScheme() - Initialize default ButtonDropDownScheme with default themezation
 # Example to create ButtonDropDownScheme:
 # Code
 ```
 let scheme = ButtonDropDownScheme()
 ```
 */
@available(iOS 14.0.0, *)
public struct ButtonDropDownScheme: AppThemeScheme {

    // MARK: - Public Properties

    /// List cell scheme.
    public var listCellScheme: ListCellScheme

    /// Center view scheme
    public var centerViewScheme: ButtonWithArrowListViewScheme

    // MARK: - Initializer

    public init(theme: AppTheme = .default) {
        listCellScheme = ListCellScheme(theme: theme)
        centerViewScheme = ButtonWithArrowListViewScheme(theme: theme)
    }

}
