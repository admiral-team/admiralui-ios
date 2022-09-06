//
//  PinCodeNumberViewScheme.swift
//  AdmiralSwiftUI
//
//  Created on 30.08.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources
/**
 PinCodeNumberViewScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - PinCodeNumberViewScheme() - Initialize default PinCodeNumberViewScheme with default themezation
 # Example to create PinCodeNumberViewScheme:
 # Code
 ```
 let scheme = PinCodeNumberViewScheme()
 ```
 */
@available(iOS 14.0.0, *)
public struct PinCodeNumberViewScheme: AppThemeScheme {

    // MARK: - Properties

    /// The background color
    public var backgroundColor = ControlParameter<AColor>()

    /// The background color
    public var imageColor: AColor

    /// The background color
    public var textColor: AColor

    /// The background color
    public var textFont: SwiftUI.Font

    // MARK: - Initializer

    public init(theme: AppTheme = .default) {
        backgroundColor.set(parameter: theme.colors.backgroundBasic, for: .normal)
        backgroundColor.set(parameter: theme.colors.backgroundSelected, for: .highlighted)

        textColor = theme.colors.textPrimary
        imageColor = theme.colors.elementPrimary
        // TODO: - Fix font
        textFont = SwiftUI.Font.system(size: 36.0)
    }

}
