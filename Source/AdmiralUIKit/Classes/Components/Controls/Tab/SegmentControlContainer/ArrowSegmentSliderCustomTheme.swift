//
//  ArrowSegmentSliderCustomTheme.swift
//  AdmiralUI
//
//  Created on 08.02.2021.
//

import AdmiralTheme
import AdmiralUIResources

public struct ArrowSegmentSliderCustomTheme {
    var imageTintColor: AColor
    var backgroundColor: AColor

    init() {
        self.init(theme: AppTheme.default)
    }
    
    init(theme: AppTheme) {
        backgroundColor = .clear
        imageTintColor = theme.colors.backgroundAdditionalOne
    }
}
