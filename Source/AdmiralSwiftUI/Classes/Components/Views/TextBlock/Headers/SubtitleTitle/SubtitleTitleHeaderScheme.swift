//
//  SubtitleTitleHeaderScheme.swift
//  AdmiralSwiftUI
//
//

import AdmiralTheme
import AdmiralUIResources
/**
 SubtitleTitleHeaderScheme - the visual scheme of SubtitleTitleHeader.
 You can create a by specifying the following parameters in init:
 - SubtitleTitleHeaderScheme() - Initialize default TitleHeaderScheme with default themezation
 # Example to create SubtitleTitleHeaderScheme:
 # Code
 ```
 let scheme = SubtitleTitleHeaderScheme()
 ```
 */
@available(iOS 14.0.0, *)
public struct SubtitleTitleHeaderScheme: AppThemeScheme {

    // MARK: - Public Properties

    /// List cell scheme.
    public var listCellScheme: ListCellScheme

    /// Center view scheme
    public var centerViewScheme: SubtitleTitleListViewScheme
    
    // MARK: - Initializer

    public init(theme: AppTheme = .default) {
        listCellScheme = ListCellScheme(theme: theme)
        centerViewScheme = SubtitleTitleListViewScheme(theme: theme)
    }

}
