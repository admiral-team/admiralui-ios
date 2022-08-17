//
//  LinePageControllScheme.swift
//  AdmiralSwiftUI
//
//  Created on 31.05.2022.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources

@available(iOS 14.0.0, *)
public struct PageControlViewScheme: AppThemeScheme {

    // MARK: - Properties

    /// The backgroundColor of PageControlView.
    public var backgroundColor = ControlParameter<AColor>()

    // MARK: - Initializer

    public init() {
        self.init(theme: AppTheme.default)
    }
    
    public init(theme: AppTheme) {
        backgroundColor.set(parameter: theme.colors.textSecondary, for: .normal)
        backgroundColor.set(parameter: theme.colors.textPrimary, for: .selected)
    }
    
}
