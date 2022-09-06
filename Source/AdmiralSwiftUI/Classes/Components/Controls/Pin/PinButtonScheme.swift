//
//  PinButtonScheme.swift
//  AdmiralSwiftUI
//
//  Created on 13.08.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources
/**
 PinButtonScheme - the visual scheme of PinButtonStyle.
 You can create a by specifying the following parameters in init:
 - PinButtonScheme() - Initialize default PinButtonScheme with default themezation
Example to create PinButtonScheme:
Code
 ```
let scheme = PinButtonScheme()
 ```
 */
@available(iOS 14.0.0, *)
public struct PinButtonScheme: AppThemeScheme {

    // MARK: - Properties

    /// The selected backgroundColor of PinButton
    public var selectedBackgroundColor: AColor

    /// The background color of PinButton
    public var backgroundColor: AColor

    /// The shadow color of PinButton
    public let shadowColor: AColor

    // MARK: - Initializer

    public init(theme: AppTheme = .default) {
        let alpha = theme.colors.disabledAlpha
        self.backgroundColor = theme.colors.backgroundAccent
        self.selectedBackgroundColor = theme.colors.backgroundAccent.withAlpha(alpha)
        self.shadowColor = theme.colors.backgroundShadow
    }

}

