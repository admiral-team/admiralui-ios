//
//  ThemeColorsViewController.swift
//  ExampleiOS
//
//  Created on 19.02.2021.
//

import AdmiralUIKit
import AdmiralTheme
import UIKit

protocol ThemeColorsViewControllerDelegate: AnyObject {
    func updateColor(_ viewController: ThemeColorsViewController, colorToken: ColorToken)
}

final class ThemeColorsViewController: BaseTableViewController {
        
    weak var delegate: ThemeColorsViewControllerDelegate?
    
    var colorTokens: [String: [ColorToken]] = [:] {
        didSet { reloadData() }
    }
    
    var isEditEnabled: Bool = true {
        didSet { reloadData() }
    }
    
    private var editingTheme: AppTheme?
    private let repository = ThemesRepostory.default

    override func viewDidLoad() {
        super.viewDidLoad()
        isThemeSwitchButtonHidden = true
        setSegmentControl(hidden: true)
        setupTableView()
    }
    
    override func apply(theme: AppTheme) {
        super.apply(theme: theme)
        reloadData()
    }
    
    func reloadData() {
        guard isViewLoaded else { return }
        tableViewManager.sections = createSections()
    }
    
    private func setupTableView() {
        tableView.registerCell(ColorTokenCell.self)
        tableView.separatorStyle = .none
        tableView.sectionHeaderHeight = LayoutGrid.halfModule * 16
        tableView.estimatedSectionHeaderHeight = LayoutGrid.halfModule * 16
        tableView.sectionFooterHeight = .leastNonzeroMagnitude
        tableView.contentInset.bottom = LayoutGrid.module * 9
        tableView.registerSupplementary(MenuTableViewHeaderView.self)
        reloadData()
    }
    
    private func createSections() -> [MenuListSectionViewModel] {
        let tokens = colorTokens
        let sections: [MenuListSectionViewModel] = tokens.keys.sorted().map() { key in
            let colors = tokens[key] ?? []
            let groupName = key.capitalized
            let items = colors.map() { token in
                ColorTokenListItem(
                    token: token,
                    isEditEnabled: isEditEnabled,
                    didSelect: { [weak self] in
                        guard let self = self else { return }
                        guard self.isEditEnabled else { return }
                        self.presentEdit(token: token)
                    })
            }
            return MenuListSectionViewModel(items: items, header: MenuTableViewHeaderViewViewModel(title: groupName))
        }
        
        return sections
    }
    
    private func presentEdit(token: ColorToken) {
        let viewController = ColorEditViewController()
        viewController.colorToken = token
        viewController.delegate = self
        navigationController?.pushViewController(viewController, animated: true)
    }
    
}

// MARK: - EditColorViewControllerDelegate

extension ThemeColorsViewController: ColorEditViewControllerDelegate {
    
    func didFinishEditing(_ viewController: ColorEditViewController) {
        let token = viewController.colorToken !! fatalError()
        
        for colorObj in colorTokens {
            let colors = colorObj.value
            for index in 0..<colors.count {
                if colors[index].name == token.name {
                    colorTokens[colorObj.key]?[index] = token
                    break
                }
            }
        }
        navigationController?.popViewController(animated: true)
        delegate?.updateColor(self, colorToken: token)
    }
    
}
