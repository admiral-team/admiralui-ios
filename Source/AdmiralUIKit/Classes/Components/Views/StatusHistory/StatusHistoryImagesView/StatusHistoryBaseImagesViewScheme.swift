//
//  StatusHistoryBaseImagesViewScheme.swift
//  AdmiralUI
//
//  Created on 23.12.2020.
//

import UIKit
import AdmiralCore
import AdmiralTheme
import AdmiralUIResources

/**
 StatusHistoryBaseImagesViewScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - StatusHistoryBaseImagesViewScheme() - Initialize default StatusHistoryBaseImagesViewScheme with default themezation
Example to create StatusHistoryBaseImagesViewScheme:
Code
 ```
let scheme = StatusHistoryBaseImagesViewScheme()
 ```
 */
public struct StatusHistoryBaseImagesViewScheme: AppThemeScheme {

    /// Image view background color.
    public var imageViewBackgroundColor: AColor

    /// Image view border color.
    public var imageViewBorderColor: AColor

    public init(theme: AppTheme = .default) {
        imageViewBackgroundColor = theme.colors.backgroundAdditionalOnePressed
        imageViewBorderColor = theme.colors.backgroundBasic
    }
    
}
