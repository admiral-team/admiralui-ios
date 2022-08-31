//
//  BadgeArrowListViewScheme.swift
//  AdmiralSwiftUI
//
//  Created on 19.11.2021.
//

import UIKit
import AdmiralTheme
import AdmiralUIResources
/**
 BadgeArrowListViewScheme - the visual scheme of BadgeArrowListView.
 You can create a by specifying the following parameters in init:
 - BadgeArrowListViewScheme() - Initialize default BadgeArrowListViewScheme with default themezation
 - BadgeArrowListViewScheme(
 arrowListViewScheme: ArrowListViewScheme,
 badgeViewScheme: BadgeViewScheme
 )
 # Example to create BadgeArrowListViewScheme:
 # Code
 ```
 let scheme = BadgeArrowListViewScheme()
 ```
 */
public struct BadgeArrowListViewScheme: AppThemeScheme {

    // MARK: - Public Properties

    /// The visual scheme of ArrowListView
    public var arrowListViewScheme: ArrowListViewScheme

    /// The visual scheme of badgeView
    public var badgeViewScheme: BadgeViewScheme

    // MARK: - Initializer

    public init(theme: AppTheme = .default) {
        arrowListViewScheme = ArrowListViewScheme(theme: theme)
        badgeViewScheme = BadgeViewScheme(theme: theme)
    }

    public init(
        arrowListViewScheme: ArrowListViewScheme,
        badgeViewScheme: BadgeViewScheme
    ) {
        self.arrowListViewScheme = arrowListViewScheme
        self.badgeViewScheme = badgeViewScheme
    }
}

