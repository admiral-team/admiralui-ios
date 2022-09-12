//
//  TwoTitleGhostButtonStyle.swift
//  AdmiralSwiftUI
//
//  Created on 06.07.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources
/**
 TwoTitleGhostButtonScheme - the visual scheme of PageControlView.
 You can create a by specifying the following parameters in init:
 - TwoTitleGhostButtonScheme() - Initialize default TwoTitleGhostButtonScheme with default themezation
 - TwoTitleGhostButtonScheme(
     backgroundColor: AColor,
     leftGhostButtonScheme: GhostButtonScheme,
     rightGhostButtonScheme: GhostButtonScheme
   )
 # Example to create TwoTitleGhostButtonScheme:
 # Code
 ```
let scheme = TwoTitleGhostButtonScheme()
 ```
 */
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

    public init(theme: AppTheme = .default) {
        backgroundColor = theme.colors.backgroundBasic
        leftGhostButtonScheme = GhostButtonScheme(theme: theme)
        rightGhostButtonScheme = GhostButtonScheme(theme: theme)
    }

    public init(
        backgroundColor: AColor,
        leftGhostButtonScheme: GhostButtonScheme,
        rightGhostButtonScheme: GhostButtonScheme
    ) {
        self.backgroundColor = backgroundColor
        self.leftGhostButtonScheme = leftGhostButtonScheme
        self.rightGhostButtonScheme = rightGhostButtonScheme
    }

}
