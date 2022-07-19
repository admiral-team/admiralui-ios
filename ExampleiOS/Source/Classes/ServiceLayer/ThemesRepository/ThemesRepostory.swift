//
//  ThemeRepostory.swift
//  ExampleiOS
//
//  Created on 17.02.2021.
//

import AdmiralUIResources
import AdmiralUIKit
import AdmiralSwiftUI
import AdmiralTheme
import Foundation

final class ThemesRepostory {
    
    static let `default` = ThemesRepostory()
    
    private let manager = Appearance.shared.themeManager
    private let storage = AppThemeUserDefaultsStorage()
    
    var selectedTheme: AppTheme? {
        storage.selectedTheme
    }
    
    var themes: [AppTheme] {
        storage.themes
    }
    
    func save(theme: AppTheme, autoChangeDuplicateName: Bool = true) {
        var themes = self.themes
        
        if let index = themes.firstIndex(of: theme) {
            themes.remove(at: index)
        }
        
        let themeNames = themes.map({ $0.displayName })
        
        if themeNames.contains(theme.displayName) {
            theme.displayName = (theme.displayName ?? "") + " new"
        }
        
        try? storage.save(theme: theme)
    }
    
    func remove(theme: AppTheme, autoSelectNewTheme: Bool = true) {
        try? storage.removeTheme(forId: theme.identifier)
        
        if autoSelectNewTheme && selectedTheme == nil {
            let firstTheme = themes.first ?? AppTheme.default
            try? storage.selectTheme(withId: firstTheme.identifier)
            manager.theme = firstTheme
        }
    }
    
    func apply(theme: AppTheme) {
        manager.theme = theme
        if #available(iOS 14.0, *) {
            SwiftUIThemeManager.shared.theme = theme
        }
        try? storage.selectTheme(withId: theme.identifier)
    }
    
    func initialConfiguration() {
        let light = try? storage.theme(forId: AppTheme.ThemeIdentifiers.light)
        let dark = try? storage.theme(forId: AppTheme.ThemeIdentifiers.dark)
        let smeLight = try? storage.theme(forId: AppTheme.ThemeIdentifiers.sMELight)
        let smeDark = try? storage.theme(forId: AppTheme.ThemeIdentifiers.sMEDark)
        
        if light == nil {
            save(theme: AppTheme.light)
        }
        
        if dark == nil {
            save(theme: AppTheme.dark)
        }
        
        if smeLight == nil {
            save(theme: AppTheme.sMELight)
        }
        
        if smeDark == nil {
            save(theme: AppTheme.sMEDark)
        }
        
        if let selectedTheme = selectedTheme {
            if selectedTheme != manager.theme {
                manager.theme = selectedTheme
                if #available(iOS 14.0, *) {
                    SwiftUIThemeManager.shared.theme = selectedTheme
                }
            }
        } else {
            try? storage.selectTheme(withId: manager.theme.identifier)
        }
    }
    
    static func colorTokens(for theme: AppTheme) -> [String: [ColorToken]] {
        let palette = theme.colors
        let allColors = (try? palette.allColors()) ?? [:]
        
        let colors = allColors
            .sorted() { $0.key < $1.key }
            .map() { ColorToken(color: $0.value.uiColor, name: $0.key) }
        
        let groupedColors = Dictionary(
            grouping: colors,
            by: { splitString($0.name).first ?? "" }
        )
        
        return groupedColors
    }
    
    static func replace(token: ColorToken, for theme: AppTheme) {
        guard
            var colors = try? theme.colors.asDictionary(),
            let color = try? AColor(color: token.color).asDictionary()
        else {
            return
        }
        
        colors[token.name] = color

        guard
            let data = try? JSONSerialization.data(withJSONObject: colors),
            let decodedColors = try? JSONDecoder().decode(ColorPalette.self, from: data)
        else { return }
    
        theme.colors = decodedColors
    }
    
    private static func splitString(_ string: String) -> [String] {
        guard let regex = try? NSRegularExpression(pattern: "([a-z]*)([A-Z])") else { return [] }
        return regex.stringByReplacingMatches(
            in: string,
            range: NSRange(0..<string.utf16.count),
            withTemplate: "$1 $2")
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: " ")
    }

    
}

private extension ColorPalette {
    
    func allColors() throws -> [String: AColor] {
        var result: [String: AColor] = [:]
        
        let mirror = Mirror(reflecting: self)
        
        guard
            let style = mirror.displayStyle,
            style == .struct || style == .class
        else {
            throw NSError()
        }
        
        for (property, value) in mirror.children {
            guard
                let property = property,
                let value = value as? AColor
            else { continue }
            
            result[property] = value
        }
        
        return result
    }
    
}
