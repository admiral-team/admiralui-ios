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
    
    public var arrowListViewScheme: ArrowListViewScheme
    public var badgeViewScheme: BadgeViewScheme
    
    public init(theme: AppTheme) {
        arrowListViewScheme = ArrowListViewScheme(theme: theme)
        badgeViewScheme = BadgeViewScheme(theme: theme)
    }
}

