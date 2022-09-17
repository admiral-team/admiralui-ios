//
//  ParagraphViewScheme.swift
//  AdmiralSwiftUI
//
//  Created by ADyatkov on 17.09.2022.
//

import AdmiralTheme
import AdmiralUIResources
/**
 ParagraphViewScheme - the visual scheme of ParagraphView.
 You can create a by specifying the following parameters in init:
 - ParagraphViewScheme() - Initialize default ParagraphViewScheme with default themezation
 # Example to create ParagraphViewScheme:
 # Code
 ```
 let scheme = ParagraphViewScheme()
 ```
 */
@available(iOS 14.0.0, *)
public struct ParagraphViewScheme: AppThemeScheme {

    // MARK: - Public Properties

    /// List cell scheme.
    public var listCellScheme: ListCellScheme

    // MARK: - Initializer

    public init(theme: AppTheme = .default) {
        listCellScheme = ListCellScheme(theme: theme)
    }

}
