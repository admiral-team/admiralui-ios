//
//  MapButtonScheme.swift
//  AdmiralSwiftUI
//
//  Created on 13.08.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources

@available(iOS 14.0.0, *)
public struct MapButtonScheme: AppThemeScheme {

    // MARK: - Properties

    /// The background color of SeveralPinButton
    public var backgroundColor = ControlParameter<AColor>()

    /// The image color of SeveralPinButton
    public let imageTintColor: AColor

    /// The shadow color of SeveralPinButton
    public let shadowColor: AColor

    // MARK: - Initializer

    public init() {
        self.init(theme: AppTheme.default)
    }
    
    public init(theme: AppTheme) {
        backgroundColor.set(parameter: theme.colors.backgroundExtraSurface, for: .normal)
        backgroundColor.set(parameter: theme.colors.backgroundAdditionalOne, for: .highlighted)
        imageTintColor = theme.colors.elementPrimary
        shadowColor = theme.colors.backgroundShadow
    }
    
}
