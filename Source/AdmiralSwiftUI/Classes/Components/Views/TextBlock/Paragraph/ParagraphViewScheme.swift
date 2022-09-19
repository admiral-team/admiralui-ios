//
//  ParagraphViewScheme.swift
//  AdmiralSwiftUI
//
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

    /// Leading view scheme
    public var leadingViewScheme: ImageListViewScheme

    /// Center view scheme
    public var centerViewScheme: TitleListViewScheme

    /// Trailing view scheme
    public var trailingViewScheme: IconListViewScheme

    // MARK: - Initializer

    public init(theme: AppTheme = .default) {
        listCellScheme = ListCellScheme(theme: theme)
        leadingViewScheme = ImageListViewScheme(theme: theme)
        centerViewScheme = TitleListViewScheme(theme: theme)
        trailingViewScheme = IconListViewScheme(theme: theme)
    }

}
