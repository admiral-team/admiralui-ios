//
//  StatusHistoryViewScheme.swift
//  AdmiralUI
//
//  Created on 23.12.2020.
//

import UIKit
import AdmiralTheme
import AdmiralUIResources

struct StatusHistoryViewScheme {
    
    var backgroundColor: AColor
    var statusHistoryDateViewScheme: StatusHistoryDateViewScheme
    var statusHistoryBaseImagesViewScheme: StatusHistoryBaseImagesViewScheme
    var statusHistorySummaViewScheme: StatusHistorySumViewScheme
    var statusHistoryTitleViewScheme: StatusHistoryTitleViewScheme
    var statusHistoryStatusViewScheme: StatusHistoryStatusViewScheme
    
    init() {
        self.init(theme: AppTheme.default)
    }
    
    init(theme: AppTheme) {
        backgroundColor = theme.colors.backgroundAdditionalOne
        
        statusHistoryDateViewScheme = StatusHistoryDateViewScheme(theme: theme)
        statusHistoryBaseImagesViewScheme = StatusHistoryBaseImagesViewScheme(theme: theme)
        statusHistorySummaViewScheme = StatusHistorySumViewScheme(theme: theme)
        statusHistoryTitleViewScheme = StatusHistoryTitleViewScheme(theme: theme)
        statusHistoryStatusViewScheme = StatusHistoryStatusViewScheme(theme: theme)
    }
}
