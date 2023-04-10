//
//  MapButtonScheme.swift
//  AdmiralUIKit
//
//  Created on 18.02.2022.
//

import AdmiralCore
import AdmiralTheme
import AdmiralUIResources

/**
 MapButtonScheme - the visual scheme.
 You can create a by specifying the following parameters in init:
 - MapButtonScheme() - Initialize default MapButtonScheme with default themezation
Example to create MapButtonScheme:
Code
 ```
let scheme = MapButtonScheme()
 ```
 */
public struct MapButtonScheme: AppThemeScheme {

    /// Background color.
    public var backgroundColor: AColor

    /// Selected background color.
    public var selectedBacgroundColor: AColor

    /// Highlighted background color.
    public var highlightedBackgroundColor: AColor

    /// Disabled background color.
    public var disabledBacgroundColor: AColor

    /// Image tint color.
    public var imageTintColor: AColor

    /// Shadow color.
    public var shadowColor: AColor

    public init(theme: AppTheme = .default) {
        let alpha = theme.colors.disabledAlpha

        backgroundColor = theme.colors.backgroundExtraSurface
        selectedBacgroundColor = theme.colors.backgroundAdditionalOne
        highlightedBackgroundColor = theme.colors.backgroundAdditionalOne
        disabledBacgroundColor = theme.colors.backgroundExtraSurface.withAlpha(alpha)
        imageTintColor = theme.colors.elementPrimary
        shadowColor = theme.colors.backgroundShadow
    }

}
