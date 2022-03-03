//
//  AppTheme.swift
//  AdmiralUI
//
//  Created on 13.11.2020.
//

import AdmiralUIResources
import Foundation

/// Application theme. Used to store application appeareance.
public class AppTheme: Theme, Codable, Equatable, NSCopying {

    public typealias ThemeIdentifier = String
    
    public enum ThemeIdentifiers {
        public static let light = "Light"
        public static let dark = "Dark"
        public static let sMELight = "SME Light"
        public static let sMEDark = "SME Dark"
    }
        
    /// The color palette.
    public var colors: ColorPalette
    
    /// The fonts palette.
    public var fonts: FontPalette
    
    /// The theme identifier.
    public let identifier: ThemeIdentifier
    
    /// The theme display name.
    public var displayName: String?
    
    /// Default app theme.
    public static var `default`: AppTheme {
        return .light
    }
    
    /// Light app theme.
    public static var light: AppTheme {
        return AppTheme(
            id: ThemeIdentifiers.light,
            colors: ColorPalette.light,
            fonts: FontPalette.default)
    }
    
    /// Dark app theme.
    public static var dark: AppTheme {
        return AppTheme(
            id: ThemeIdentifiers.dark,
            colors: ColorPalette.dark,
            fonts: FontPalette.default)
    }
    
    public static var sMELight: AppTheme {
        return AppTheme(
            id: ThemeIdentifiers.sMELight,
            colors: ColorPalette.sMELight,
            fonts: FontPalette.default)
    }
    
    /// Dark app theme.
    public static var sMEDark: AppTheme {
        return AppTheme(
            id: ThemeIdentifiers.sMEDark,
            colors: ColorPalette.sMEDark,
            fonts: FontPalette.default)
    }
    
    /// AppTheme Initializer.
    /// - Parameters:
    ///   - id: Theme identifier
    ///   - colors: Color theme
    ///   - fonts: Fonts
    public init(
        id: ThemeIdentifier,
        displayName: String? = nil,
        colors: ColorPalette,
        fonts: FontPalette) {
        self.identifier = id
        self.displayName = displayName ?? id
        self.colors = colors
        self.fonts = fonts
    }
    
    // MARK: - Equitable
    
    public static func == (lhs: AppTheme, rhs: AppTheme) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    // MARK: - NSCopying
    
    public func copy(with zone: NSZone? = nil) -> Any {
        guard let data = try? JSONEncoder().encode(self) else { fatalError("Failed to copy object") }
        guard let copy = try? JSONDecoder().decode(AppTheme.self, from: data) else { fatalError("Failed to copy object") }
        return copy
    }
    
}
