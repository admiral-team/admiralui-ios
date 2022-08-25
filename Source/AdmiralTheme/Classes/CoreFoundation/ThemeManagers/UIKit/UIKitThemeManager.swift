//
//  AppThemeManager.swift
//  AdmiralUI
//
//  Created on 13.11.2020.
//

import UIKit

/// Application theme manager.
public class UIKitThemeManager {

    /// Current application theme
    public var theme: AppTheme {
        get {
            guard let theme = manager.theme as? AppTheme else {
                fatalError("Unknown error")
            }
            return theme
        }
        set { manager.theme = newValue }
    }
    
    private let manager = ThemeManager()
    
    /// Initializer
    public init() {
        manager.theme = AppTheme.default
    }
    
    /// Provides automated theme notification via `closure`.
    ///
    /// - Parameters:
    ///   - theme: the theme to apply
    ///   - updates: closure for applying provided the theme to the sender
    ///
    public func observe(updates: ((AppTheme) -> Void)?) -> ThemeDisposable {
        return manager.observe(theme: AppTheme.self, closure: { updates?($0) })
    }

    /// Provides automated theme management for `themeable`.
    ///
    /// - Parameters:
    ///   - theme: `AppThemeable`'s sub-theme's key-path relative to the Manager's current theme to apply
    ///   - themeable: the object to have the theme applied to
    func manage<U>(
        theme: U.AssociatedTheme.Type,
        for themeable: U) where U: AppThemeable {
        manager.manage(theme: theme, for: themeable)
    }
    
}
