//
//  TitleButtonDropDownScheme.swift
//  AdmiralSwiftUI
//
//  Created by ADyatkov on 17.09.2022.
//

import AdmiralTheme
import AdmiralUIResources
/**
 TitleButtonDropDownScheme - the visual scheme of TitleButtonDropDown.
 You can create a by specifying the following parameters in init:
 - TitleButtonDropDownScheme() - Initialize default TitleButtonDropDownScheme with default themezation
 # Example to create TitleButtonDropDownScheme:
 # Code
 ```
 let scheme = TitleButtonDropDownScheme()
 ```
 */
@available(iOS 14.0.0, *)
public struct TitleButtonDropDownScheme: AppThemeScheme {

    // MARK: - Public Properties

    /// List cell scheme.
    public var listCellScheme: ListCellScheme

    // MARK: - Initializer

    public init(theme: AppTheme = .default) {
        listCellScheme = ListCellScheme(theme: theme)
    }

}
