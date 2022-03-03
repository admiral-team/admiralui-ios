//
//  StatusHistoryBaseImagesViewScheme.swift
//  AdmiralUI
//
//  Created on 23.12.2020.
//

import UIKit
import AdmiralTheme
import AdmiralUIResources

struct StatusHistoryBaseImagesViewScheme {
    
    var imageViewBackgroundColor: AColor
    var imageViewBorderColor: AColor
    
    init() {
        self.init(theme: AppTheme.default)
    }
    
    init(theme: AppTheme) {
        imageViewBackgroundColor = theme.colors.backgroundAdditionalOnePressed
        imageViewBorderColor = theme.colors.backgroundBasic
    }
}
