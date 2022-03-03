//
//  TwoTitleGhostButtonStyle.swift
//  AdmiralSwiftUI
//
//  Created on 06.07.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources

@available(iOS 14.0.0, *)
public struct TwoTitleGhostButtonScheme: AppThemeScheme {
    
    public var backgroundColor: AColor
    public var leftGhostButtonScheme: GhostButtonScheme
    public var rightGhostButtonScheme: GhostButtonScheme
    
    public init(theme: AppTheme) {
        backgroundColor = theme.colors.backgroundBasic
        leftGhostButtonScheme = GhostButtonScheme(theme: theme)
        rightGhostButtonScheme = GhostButtonScheme(theme: theme)
    }

}
