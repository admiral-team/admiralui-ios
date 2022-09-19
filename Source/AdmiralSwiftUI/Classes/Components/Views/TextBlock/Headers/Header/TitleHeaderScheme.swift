//
//  TitleHeaderScheme.swift
//  AdmiralSwiftUI
//
//

import AdmiralTheme
import AdmiralUIResources
/**
 TitleHeaderScheme - the visual scheme of TitleHeader.
 You can create a by specifying the following parameters in init:
 - TitleHeaderScheme() - Initialize default TitleHeaderScheme with default themezation
 # Example to create TitleHeaderScheme:
 # Code
 ```
 let scheme = TitleHeaderScheme()
 ```
 */
@available(iOS 14.0.0, *)
public struct TitleHeaderScheme: AppThemeScheme {

    // MARK: - Public Properties

    /// List cell scheme.
    public var listCellScheme: ListCellScheme

    /// Center view scheme
    public var centerViewScheme: TitleListViewScheme

    // MARK: - Initializer

    public init(theme: AppTheme = .default) {
        listCellScheme = ListCellScheme(theme: theme)
        centerViewScheme = TitleListViewScheme(theme: theme)
    }

}
