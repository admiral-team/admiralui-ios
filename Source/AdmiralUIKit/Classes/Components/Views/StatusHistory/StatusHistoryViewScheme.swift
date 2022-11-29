//
//  StatusHistoryViewScheme.swift
//  AdmiralUI
//
//  Created on 23.12.2020.
//

import UIKit
import AdmiralTheme
import AdmiralUIResources

/**
 StatusHistoryViewScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - StatusHistoryViewScheme() - Initialize default StatusHistoryViewScheme with default themezation
Example to create StatusHistoryViewScheme:
Code
 ```
let scheme = StatusHistoryViewScheme()
 ```
 */
public struct StatusHistoryViewScheme: AppThemeScheme {

    /// Background color.
    public var backgroundColor: AColor

    /// Status history date view scheme.
    public var statusHistoryDateViewScheme: StatusHistoryDateViewScheme

    /// Status history base images view scheme.
    public var statusHistoryBaseImagesViewScheme: StatusHistoryBaseImagesViewScheme

    /// Status history summa view scheme.
    public var statusHistorySummaViewScheme: StatusHistorySumViewScheme

    /// Status history title view scheme.
    public var statusHistoryTitleViewScheme: StatusHistoryTitleViewScheme

    /// Status history status view scheme.
    public var statusHistoryStatusViewScheme: StatusHistoryStatusViewScheme
    
    public init(theme: AppTheme = .default) {
        backgroundColor = theme.colors.backgroundAdditionalOne
        
        statusHistoryDateViewScheme = StatusHistoryDateViewScheme(theme: theme)
        statusHistoryBaseImagesViewScheme = StatusHistoryBaseImagesViewScheme(theme: theme)
        statusHistorySummaViewScheme = StatusHistorySumViewScheme(theme: theme)
        statusHistoryTitleViewScheme = StatusHistoryTitleViewScheme(theme: theme)
        statusHistoryStatusViewScheme = StatusHistoryStatusViewScheme(theme: theme)
    }
}
