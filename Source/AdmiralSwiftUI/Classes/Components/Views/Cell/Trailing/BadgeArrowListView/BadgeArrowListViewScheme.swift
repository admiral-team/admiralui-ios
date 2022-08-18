//
//  BadgeArrowListViewScheme.swift
//  AdmiralSwiftUI
//
//  Created on 19.11.2021.
//

import UIKit
import AdmiralTheme
import AdmiralUIResources

public struct BadgeArrowListViewScheme: AppThemeScheme {

    // MARK: - Properties

    /// The arrow list view BadgeArrowList
    public var arrowListViewScheme: ArrowListViewScheme

    /// The badge view scheme of BadgeArrowList
    public var badgeViewScheme: BadgeViewScheme

    // MARK: - Initializer

    public init() {
        self.init(theme: AppTheme.default)
    }

    public init(theme: AppTheme) {
        arrowListViewScheme = ArrowListViewScheme(theme: theme)
        badgeViewScheme = BadgeViewScheme(theme: theme)
    }
}

