//
//  PinCodeKeyboardScheme.swift
//  AdmiralSwiftUI
//
//  Created on 31.08.2021.
//

import SwiftUI
import Combine
import AdmiralTheme
import AdmiralUIResources

@available(iOS 14.0.0, *)
public struct PinCodeKeyboardScheme: AppThemeScheme {
    
    public var backgroundColor: AColor
    
    public init(theme: AppTheme) {
        backgroundColor = theme.colors.backgroundBasic
    }

}
