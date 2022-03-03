//
//  ThemeStorage.swift
//  AdmiralUI
//
//  Created on 15.02.2021.
//

import Foundation

public protocol AppThemeStorage {
    var themes: [AppTheme] { get }
    var selectedTheme: AppTheme? { get }
    
    func reset() throws
    func save(theme: AppTheme) throws
    func removeTheme(forId id: AppTheme.ThemeIdentifier) throws
    func selectTheme(withId id: AppTheme.ThemeIdentifier?) throws
    func theme(forId id: AppTheme.ThemeIdentifier) throws -> AppTheme?
}

public final class AppThemeUserDefaultsStorage: AppThemeStorage {
    
    // MARK: - Public Properties
    
    public var themes: [AppTheme] {
        guard let themesList = try? defaults.object(ThemesList.self, forKey: themesListKey) else { return [] }
        return themesList.themes.compactMap() { try? defaults.object(AppTheme.self, forKey: $0) }
    }
    
    public var selectedTheme: AppTheme? {
        guard let id = defaults.value(forKey: selectedThemeKey) as? String else { return nil }
        return try? defaults.object(AppTheme.self, forKey: id)
    }
    
    public var prefix = "AppThemeUserDefaultsStorage"
    
    // MARK: - Private Properties
    
    private struct ThemesList: Codable {
        private(set) var themes = [AppTheme.ThemeIdentifier]()
        
        mutating func insert(_ id: AppTheme.ThemeIdentifier) {
            if let index = themes.firstIndex(of: id) { themes.remove(at: index) }
            themes.append(id)
        }
        
        mutating func remove(_ id: AppTheme.ThemeIdentifier) {
            guard let index = themes.firstIndex(of: id) else { return } 
            themes.remove(at: index)
        }
    }
    
    private let defaults = UserDefaults.standard
    
    private var selectedThemeKey: String {
        return prefix + ".SelectedThemeKey"
    }
    
    private var themesListKey: String {
        return prefix + ".ThemesListKey"
    }
        
    // MARK: - Public Methods
    
    public init() {
        //
    }
        
    // MARK: - AppThemeStorage
    
    public func reset() throws {
        let list = try defaults.object(ThemesList.self, forKey: themesListKey) ?? ThemesList()
        list.themes.forEach() { defaults.set(nil, forKey: $0) }
        try selectTheme(withId: nil)
        defaults.set(nil, forKey: themesListKey)
    }
    
    public func save(theme: AppTheme) throws {
        try defaults.set(object: theme, forKey: theme.identifier)
        try addThemeToList(forKey: theme.identifier)
    }
    
    public func removeTheme(forId id: AppTheme.ThemeIdentifier) throws {
        defaults.set(nil, forKey: id)
        try removeThemeFromList(forKey: id)
    }
    
    public func selectTheme(withId id: AppTheme.ThemeIdentifier?) throws {
        defaults.set(id, forKey: selectedThemeKey)
    }
    
    public func theme(forId id: AppTheme.ThemeIdentifier) throws -> AppTheme? {
        return try defaults.object(AppTheme.self, forKey: id)
    }
    
    // MARK: - Private Methods
    
    private func addThemeToList(forKey key: String) throws {
        var list = try defaults.object(ThemesList.self, forKey: themesListKey) ?? ThemesList()
        list.insert(key)
        try defaults.set(object: list, forKey: themesListKey)
    }

    private func removeThemeFromList(forKey key: String) throws {
        guard var list = try defaults.object(ThemesList.self, forKey: themesListKey) else { return }
        guard !list.themes.isEmpty else { defaults.set(nil, forKey: key); return }
        defaults.setValue(nil, forKey: key)
        list.remove(key)
        try defaults.set(object: list, forKey: themesListKey)
    }
    
}

private extension UserDefaults {
    
    func object<T: Codable>(_ type: T.Type, forKey key: String, usingDecoder decoder: JSONDecoder = JSONDecoder()) throws -> T? {
        guard let data = self.value(forKey: key) as? Data else { return nil }
        return try decoder.decode(type.self, from: data)
    }

    func set<T: Codable>(object: T, forKey key: String, usingEncoder encoder: JSONEncoder = JSONEncoder()) throws {
        let data = try encoder.encode(object)
        self.set(data, forKey: key)
    }
    
}
