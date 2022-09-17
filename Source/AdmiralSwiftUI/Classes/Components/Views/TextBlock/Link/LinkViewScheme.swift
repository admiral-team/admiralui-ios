//
//  LinkViewScheme.swift
//  AdmiralSwiftUI
//
//  Created by ADyatkov on 17.09.2022.
//

import AdmiralTheme
import AdmiralUIResources
/**
 LinkViewScheme - the visual scheme of LinkViewScheme.
 You can create a by specifying the following parameters in init:
 - LinkViewScheme() - Initialize default LinkViewScheme with default themezation
 # Example to create LinkViewScheme:
 # Code
 ```
 let scheme = LinkViewScheme()
 ```
 */
@available(iOS 14.0.0, *)
public struct LinkViewScheme: AppThemeScheme {

    // MARK: - Public Properties

    /// List cell scheme.
    public var listCellScheme: ListCellScheme

    /// Content list view scheme
    public var contentListViewScheme: ButtonListViewScheme

    // MARK: - Initializer

    public init(theme: AppTheme = .default) {
        listCellScheme = ListCellScheme(theme: theme)
        contentListViewScheme = ButtonListViewScheme(theme: theme)
    }

}
