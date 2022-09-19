//
//  TitleSubtitleHeaderScheme.swift
//  AdmiralSwiftUI
//
//

import AdmiralTheme
import AdmiralUIResources
/**
 TitleSubtitleHeaderScheme - the visual scheme of TitleSubtitleHeader.
 You can create a by specifying the following parameters in init:
 - TitleSubtitleHeaderScheme() - Initialize default TitleHeaderScheme with default themezation
 # Example to create TitleSubtitleHeaderScheme:
 # Code
 ```
 let scheme = TitleSubtitleHeaderScheme()
 ```
 */
@available(iOS 14.0.0, *)
public struct TitleSubtitleHeaderScheme: AppThemeScheme {

    // MARK: - Public Properties

    /// List cell scheme.
    public var listCellScheme: ListCellScheme

    /// Center view scheme
    public var centerViewScheme: TitleSubTitleSubtitleListViewScheme

    // MARK: - Initializer

    public init(theme: AppTheme = .default) {
        listCellScheme = ListCellScheme(theme: theme)
        centerViewScheme = TitleSubTitleSubtitleListViewScheme(theme: theme)
    }

}
