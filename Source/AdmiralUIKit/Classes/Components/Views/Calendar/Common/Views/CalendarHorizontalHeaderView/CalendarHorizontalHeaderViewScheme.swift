//
//  CalendarHorizontalHeaderViewScheme.swift
//  AdmiralUIKit
//
//  Created on 10.11.2021.
//

import AdmiralTheme
import AdmiralUIResources

public struct CalendarHorizontalHeaderViewScheme {

    var backgroundColor: AColor
    var buttonWithArrowScheme: ButtonWithArrowScheme
    var ghostButtonCustomScheme: GhostButtonCustomScheme

    public init() {
        self.init(theme: AppTheme.default)
    }
    
    public init(theme: AppTheme) {
        backgroundColor = theme.colors.backgroundBasic
        buttonWithArrowScheme = ButtonWithArrowScheme(theme: theme)
        ghostButtonCustomScheme = GhostButtonCustomScheme(theme: theme)
    }
            
}
