//
//  Appearance.swift
//  AdmiralUI
//
//  Created on 09.11.2020.
//

import AdmiralUIResources
import UIKit

/// A collection of methods that gives you access to the appearance  for application.
public final class Appearance {
    
    /// Turn On/Off accessibility in application
    public var isAccessabilitySupportEnabled: Bool = true

    /// Current application theme.
    public var theme: AppTheme {
        get {
            return uikitThemeManager.theme
        } set {
            swiftuiThemeManager.theme = newValue
            uikitThemeManager.theme = newValue
        }
    }
    
    /// Application Theme manager
    public let uikitThemeManager: UIKitThemeManager
    public let swiftuiThemeManager: SwiftUIThemeManager

    /// Application appearance entry point. Can be used to setup default colors and fonts.
    public static let shared: Appearance = Appearance(
        uikitThemeManager: UIKitThemeManager(),
        swiftuiThemeManager: SwiftUIThemeManager()
    )

    /// Default apperance initializer
    /// - Parameter themeManager: Theme manager.
    init(
        uikitThemeManager: UIKitThemeManager,
        swiftuiThemeManager: SwiftUIThemeManager
    ) {
        self.uikitThemeManager = uikitThemeManager
        self.swiftuiThemeManager = swiftuiThemeManager
    }
    
    /// Call this method in app delegate before using theme and theme manager
    public static func prepare() {
        FontPalette.registerDefaultFonts()
    }
    
}
