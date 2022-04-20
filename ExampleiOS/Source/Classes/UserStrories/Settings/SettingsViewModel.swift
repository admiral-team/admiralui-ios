//
//  SettingsViewModel.swift
//  ExampleiOS
//
//  Created on 19.04.2022.
//

import AdmiralUIResources
import UIKit

final class SettingsViewModel {

    enum SwitchAction {
        case systemChandeTheme
        case changeSwiftUI
    }

    // MARK: Internal Properties

    let defaults = UserDefaults.standard
    var isEnabled: Bool
    var action: SwitchAction?
    var items: [SwitcherListTableViewCellViewModel]

    // MARK: - Initializer

    init() {
        if #available(iOS 14, *) {
            isEnabled = true
        } else {
            isEnabled = false
        }

        items = [
            SwitcherListTableViewCellViewModel(
                title: "Переключить на Swift UI",
                image: Asset.Settings.chip.image,
                isOn: defaults.bool(forKey: UserDefaults.Keys.isSwiftUIOn),
                key: UserDefaults.Keys.isSwiftUIOn,
                isEnabled: isEnabled
            ),
            SwitcherListTableViewCellViewModel(
                title: "Автоматическое переключение темы",
                image: Asset.Settings.chip.image,
                isOn: defaults.bool(forKey: UserDefaults.Keys.isSystemChangeThemeOn),
                key: UserDefaults.Keys.isSystemChangeThemeOn,
                isEnabled: isEnabled
            )
        ]
    }

    // MARK: - Computed Properties

    var title: String {
        return "Настройки"
    }

    var sections: [MainSectionViewModel] {
        [MainSectionViewModel(items: items)]
    }

    // MARK: - Internal Properties

    func setValue(for key: String, isOn: Bool) {
        defaults.setValue(isOn, forKey: key)
    }

    func changeAction(by key: String) {
        switch key {
        case UserDefaults.Keys.isSystemChangeThemeOn:
            action = .systemChandeTheme
        case UserDefaults.Keys.isSwiftUIOn:
            action = .changeSwiftUI
        default:
            break
        }
    }

}
