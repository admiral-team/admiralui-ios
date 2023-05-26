//
//  SettingsViewController.swift
//  ExampleiOS
//
//  Created on 09.11.2020.
//

import AdmiralUIKit
import AdmiralTheme
import UIKit

final class SettingsViewController: BaseTableViewController {
    
    // MARK: - Private Properties
    
    private let defaults = UserDefaults.standard
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSegmentControl(hidden: true)
        isThemeSwitchButtonHidden = true
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "Настройки"
    }
    
    // MARK: - Private Methods
    
    private func setupTableView() {
        tableView.separatorStyle = .none
        tableView.registerCell(SwitcherListTableViewCell.self)
        tableViewManager.sections = createSections()
    }
    
    private func createSections() -> [MainSectionViewModel] {
        var items = [TableViewListItem]()
        
        var isEnabled: Bool = true
        
        if #available(iOS 14, *) {
            isEnabled = true
        } else {
            isEnabled = false
        }
        
        let swiftUISwitchItem = SwitcherListTableViewCellViewModel(
            title: "Переключить на Swift UI",
            image: Asset.Settings.chip.image,
            isOn: defaults.bool(forKey: UserDefaults.Keys.isSwiftUIOn),
            key: UserDefaults.Keys.isSwiftUIOn,
            accessibilityId: "SwitchToSwiftUI")
        swiftUISwitchItem.delegate = self
        swiftUISwitchItem.isEnabled = isEnabled
        
        items.append(swiftUISwitchItem)
        
        let systemChangeThemeItem = SwitcherListTableViewCellViewModel(
            title: "Автоматическое переключение темы",
            image: Asset.Settings.chip.image,
            isOn: defaults.bool(forKey: UserDefaults.Keys.isSystemChangeThemeOn),
            key: UserDefaults.Keys.isSystemChangeThemeOn,
            accessibilityId: "AutomaticChangeTheme")
        systemChangeThemeItem.delegate = self
        systemChangeThemeItem.isEnabled = isEnabled
        
        items.append(systemChangeThemeItem)
        
        return [MainSectionViewModel(items: items)]
    }
    
}

// MARK: - SwitcherListTableViewCellDelegate

extension SettingsViewController: SwitcherListTableViewCellDelegate {
    
    func didChangeSwitch(isOn: Bool, key: String?) {
        guard let key = key else { return }
        
        switch key {
        case UserDefaults.Keys.isSystemChangeThemeOn:
            changeSystemChangeTheme(isOn: isOn)
        case UserDefaults.Keys.isSwiftUIOn:
            changeSwitchSwiftUI(isOn: isOn)
        default:
            break
        }
    }
    
    func changeSystemChangeTheme(isOn: Bool) {
        defaults.setValue(isOn, forKey: UserDefaults.Keys.isSystemChangeThemeOn)
    }
    
    func changeSwitchSwiftUI(isOn: Bool) {
        defaults.setValue(isOn, forKey: UserDefaults.Keys.isSwiftUIOn)
        guard let tabBar = tabBarController as? BaseTabBarController else { return }
        
        tabBar.viewControllers?[0] = isOn ? tabBar.prepareSwiftUIController() : tabBar.prepareUIKitController()
        tabBar.viewControllers?[2] = isOn ? tabBar.prepareSwiftUIChatController() : tabBar.prepareUIKitChatController()
    }
    
}
