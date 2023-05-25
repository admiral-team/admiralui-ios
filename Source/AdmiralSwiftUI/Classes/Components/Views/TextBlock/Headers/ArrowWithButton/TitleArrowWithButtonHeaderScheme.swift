//
//  TitleArrowWithButtonHeaderScheme.swift
//  AdmiralSwiftUI
//
//

import AdmiralTheme
/**
 TitleArrowWithButtonHeaderScheme - the visual scheme of TitleArrowWithButtonHeader.
 You can create a by specifying the following parameters in init:
 - TitleArrowWithButtonHeaderScheme() - Initialize default TitleArrowWithButtonHeaderScheme with default themezation
 # Example to create TitleArrowWithButtonHeaderScheme:
 # Code
 ```
 let scheme = TitleArrowWithButtonHeaderScheme()
 ```
 */
@available(iOS 14.0.0, *)
public struct TitleArrowWithButtonHeaderScheme: AppThemeScheme {

    // MARK: - Public Properties

    /// List cell scheme.
    public var listCellScheme: ListCellScheme

    /// Center view scheme
    public var centerViewScheme: TitleWithImageListViewScheme

    /// Trailing view scheme
    public var trailingViewScheme: ButtonListViewScheme

    // MARK: - Initializer

    public init(theme: AppTheme = .default) {
        listCellScheme = ListCellScheme(theme: theme)
        centerViewScheme = TitleWithImageListViewScheme(theme: theme)
        trailingViewScheme = ButtonListViewScheme(theme: theme)
    }

}

