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

    private let viewModel = SettingsViewModel()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSegmentControl(hidden: true)
        isThemeSwitchButtonHidden = true
        setupItems()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = viewModel.title
    }
    
    // MARK: - Private Methods
    
    private func setupTableView() {
        tableView.separatorStyle = .none
        tableView.registerCell(SwitcherListTableViewCell.self)
        tableViewManager.sections = viewModel.sections
    }

    private func setupItems() {
        viewModel.items.enumerated().forEach { index, _ in
            viewModel.items[index].delegate = self
        }
    }

}

// MARK: - SwitcherListTableViewCellDelegate

extension SettingsViewController: SwitcherListTableViewCellDelegate {
    
    func didChangeSwitch(isOn: Bool, key: String?) {
        guard let key = key else { return }
        viewModel.changeAction(by: key)

        switch viewModel.action {
        case .systemChandeTheme:
            changeSystemChangeTheme(isOn: isOn)
        case .changeSwiftUI:
            changeSwitchSwiftUI(isOn: isOn)
        default:
            break
        }
    }
    
    func changeSystemChangeTheme(isOn: Bool) {
        viewModel.setValue(for: UserDefaults.Keys.isSystemChangeThemeOn, isOn: isOn)
    }
    
    func changeSwitchSwiftUI(isOn: Bool) {
        viewModel.setValue(for: UserDefaults.Keys.isSwiftUIOn, isOn: isOn)
        guard let tabBar = tabBarController as? BaseTabBarController else { return }
        
        tabBar.viewControllers?[0] = isOn ? tabBar.prepareSwiftUIController() : tabBar.prepareUIKitController()
        tabBar.viewControllers?[2] = isOn ? tabBar.prepareSwiftUIChatController() : tabBar.prepareUIKitChatController()
    }
    
}
