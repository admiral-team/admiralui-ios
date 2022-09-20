//
//  DropDownHeaderScheme.swift
//  AdmiralSwiftUI
//
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

    /// Center view scheme
    public var centerViewScheme: TitleListViewScheme

    /// Trailing view scheme
    public var trailingViewScheme: IconListViewScheme

    // MARK: - Initializer

    public init(theme: AppTheme = .default) {
        listCellScheme = ListCellScheme(theme: theme)
        centerViewScheme = TitleListViewScheme(theme: theme)
        trailingViewScheme = IconListViewScheme(theme: theme)
    }

}
