//
//  AdditionalTextFieldViewCustomScheme.swift
//  ExampleiOS
//
//  Created by on 21.03.2023.
//  
//


import AdmiralTheme
import UIKit

struct AdditionalTextFieldViewCustomScheme {
    
    var backgroundColor: AColor
    
    init() {
        self.init(theme: AppTheme.default)
    }
    
    init(theme: AppTheme) {
        backgroundColor = theme.colors.backgroundBasic
    }

}
