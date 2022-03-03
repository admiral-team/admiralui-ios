//
//  ThemeSwitchViewCoordinator.swift
//  ExampleiOS
//
//  Created on 24.03.2021.
//

import UIKit
import AdmiralTheme
import AdmiralUIKit
import AdmiralSwiftUI

final class ThemeSwitchViewCoordinator: ThemeSwitchViewDelegate, ThemeSwitchViewDataSource {

    // MARK: - Private Properties

    private let storage = AppThemeUserDefaultsStorage()
    private let manager = Appearance.shared.themeManager
    
    private var theme: AppTheme {
        get {
            return storage.selectedTheme ?? manager.theme
        }
        set {
            if #available(iOS 14.0.0, *) {
                SwiftUIThemeManager.shared.theme = newValue
            }
            manager.theme = newValue
        }
    }
    
    // MARK: - ThemeSwitchViewDelegate
    
    func shouldShowMenu(_ view: ThemeSwitchView) -> Bool {
        return storage.themes.count > 2
    }
    
    func didTap(_ view: ThemeSwitchView) {
        let theme: AppTheme = manager.theme == .light ? .dark : .light
        saveTheme(id: theme.identifier)
        self.theme = storage.selectedTheme ?? .default
    }
    
    func didSelect(_ view: ThemeSwitchView, at index: Int) {
        let id: AppTheme.ThemeIdentifier = storage.themes[index].identifier
        saveTheme(id: id)
        theme = storage.selectedTheme ?? .default
    }
    
    // MARK: - Private Methods
    
    private func saveTheme(id: String) {
        try? storage.selectTheme(withId: id)
    }
    
    // MARK: - ThemeSwitchViewDataSource
    
    var selectedIndex: Int? {
        let selectedTheme = storage.themes.filter({ $0.identifier == storage.selectedTheme?.identifier }).first
        return storage.themes.firstIndex(where: { $0.identifier == selectedTheme?.identifier })
    }
    
    func items(_ view: ThemeSwitchView) -> [ThemeSwitchComponentView] {
        let titles = storage.themes.map({ $0.displayName })
        let items = titles.map() { createItem(title: $0) }
        
        return items
    }

    // MARK: - Private Methods

    private func createItem(title: String?) -> ThemeSwitchComponentView {
        let item = ThemeSwitchComponentView()
        item.title = title

        return item
    }
    
}
