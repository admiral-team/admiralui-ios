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
    public static var isAccessabilitySupportEnabled: Bool = true
    
    /// Current application theme.
    public var theme: AppTheme {
        return themeManager.theme
    }
    
    /// Application Theme manager
    public let themeManager: AppThemeManager
    
    /// Application appearance entry point. Can be used to setup default colors and fonts.
    public static let shared: Appearance = Appearance(themeManager: AppThemeManager())
    
    /// Default apperance initializer
    /// - Parameter themeManager: Theme manager.
    init(themeManager: AppThemeManager) {
        self.themeManager = themeManager
    }
    
    /// Call this method in app delegate before using theme and theme manager
    public static func prepare() {
        FontPalette.registerDefaultFonts()
    }
    
}
