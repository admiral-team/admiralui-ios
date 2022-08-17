//
//  PinButtonScheme.swift
//  AdmiralSwiftUI
//
//  Created on 13.08.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources

@available(iOS 14.0.0, *)
public struct PinButtonScheme: AppThemeScheme {

    // MARK: - Properties

    /// The selected backgroundColor of PinButton
    public var selectedbackgroundColor: AColor

    /// The background color of PinButton
    public var backgroundColor: AColor

    /// The shadow color of PinButton
    public let shadowColor: AColor

    // MARK: - Initializer

    public init() {
        self.init(theme: AppTheme.default)
    }
    
    public init(theme: AppTheme) {
        let alpha = theme.colors.disabledAlpha
        
        backgroundColor = theme.colors.backgroundAccent
        selectedbackgroundColor = theme.colors.backgroundAccent.withAlpha(alpha)
        shadowColor = theme.colors.backgroundShadow
    }
    
}
