//
//  Themeable.swift
//  AdmiralUI
//
//  Created on 13.11.2020.
//

import UIKit

/// Utility protocol for enabling  themes
public protocol Themeable: AnyObject {
    associatedtype AssociatedTheme: Theme
    
    /// The defaul theme that will be used after view initialization.
    /// The default implementation of this property will return current application theme.
    var defaultTheme: AssociatedTheme { get }

    /// Apply theme to ui object.
    func apply(theme: AssociatedTheme)
}

extension AppThemeable {
    
    public var defaultTheme: AppTheme {
        return Appearance.shared.theme
    }
    
    /// Use this function to autosubscribe object to theme.
    @discardableResult
    public func autoManage() -> Self {
        Appearance.shared.uikitThemeManager.manage(theme: AppTheme.self, for: self)
        return self
    }
    
}

/// Utility protocol for enabling  application themes
public protocol AppThemeable: Themeable where AssociatedTheme == AppTheme {
    //
}

/// Utility protocol for enabling  application themes. Can be used, when you need to check if the object conforms to the protocol.
public protocol AppThemeCompatible {
    func apply(theme: AppTheme)
}

/// Typealias to support both protocols AppThemeable & AppThemeCompatible
public typealias AnyAppThemable = AppThemeable & AppThemeCompatible
