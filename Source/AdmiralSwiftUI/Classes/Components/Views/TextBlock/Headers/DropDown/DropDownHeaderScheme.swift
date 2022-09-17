//
//  DropDownHeaderScheme.swift
//  AdmiralSwiftUI
//
//  Created by ADyatkov on 17.09.2022.
//

import AdmiralTheme
import AdmiralUIResources
/**
 DropDownHeaderScheme - the visual scheme of DropDownHeader.
 You can create a by specifying the following parameters in init:
 - DropDownHeaderScheme() - Initialize default TitleHeaderScheme with default themezation
 # Example to create DropDownHeaderScheme:
 # Code
 ```
 let scheme = DropDownHeaderScheme()
 ```
 */
@available(iOS 14.0.0, *)
public struct DropDownHeaderScheme: AppThemeScheme {

    // MARK: - Public Properties

    /// List cell scheme.
    public var listCellScheme: ListCellScheme

    // MARK: - Initializer

    public init(theme: AppTheme = .default) {
        listCellScheme = ListCellScheme(theme: theme)
    }

}
