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

    // MARK: - Public Properties

    /// The background color of TwoTitleGhostButton
    public var backgroundColor: AColor

    /// The left ghost button scheme
    public var leftGhostButtonScheme: GhostButtonScheme

    /// The right ghost buttton scheme
    public var rightGhostButtonScheme: GhostButtonScheme

    // MARK: - Initializer

    public init(theme: AppTheme) {
        backgroundColor = theme.colors.backgroundBasic
        leftGhostButtonScheme = GhostButtonScheme(theme: theme)
        rightGhostButtonScheme = GhostButtonScheme(theme: theme)
    }

}
