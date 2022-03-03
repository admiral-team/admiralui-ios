//
//  BottomSheetPresentationControllerCustomTheme.swift
//  AdmiralUI
//
//  Created on 20.01.2021.
//

import AdmiralTheme
import AdmiralUIResources

struct BottomSheetPresentationControllerCustomTheme {
    
    var backgroundColor: AColor
    
    init() {
        self.init(theme: AppTheme.default)
    }
    
    init(theme: AppTheme) {
        backgroundColor = theme.colors.backgroundExtraSurface
    }
    
}
