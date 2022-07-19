//
//  ButtonsViewController.swift
//  ExampleiOS
//
//  Created on 14.06.2022.
//

import AdmiralUIKit
import UIKit

final class ButtonsViewController: BaseTableViewController {
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        setSegmentControl(hidden: true)

        super.viewDidLoad()
        tableView.separatorStyle = .none
        tableViewManager.sections = createSections()
    }
    
    // MARK: - Private Methods
    
    private func createSections() -> [MainSectionViewModel] {
        let items: [TableViewListItem] = [
            MainTitleTableViewCellViewModel(
                title: "Primary buttons",
                didSelect: { [weak self] in self?.presentPrimaryButtons() }),
            
            MainTitleTableViewCellViewModel(
                title: "Secondary buttons",
                didSelect: { [weak self] in self?.presentSecondaryButtons() }),
            
            MainTitleTableViewCellViewModel(
                title: "Ghost buttons",
                didSelect: { [weak self] in self?.presentGhostButtons() }),
            
            MainTitleTableViewCellViewModel(
                title: "Rules",
                didSelect: { [weak self] in self?.presentRules() }),
            
            MainTitleTableViewCellViewModel(
                title: "Other buttons",
                didSelect: { [weak self] in self?.presentOtherButton() })
        ]
        
        return [MainSectionViewModel(items: items)]
    }
    
    private func presentPrimaryButtons() {
        let viewController = PrimaryButtonsViewController()
        viewController.title = "Primary buttons"
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func presentSecondaryButtons() {
        let viewController = SecondaryButtonsViewController()
        viewController.title = "Secondary buttons"
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func presentGhostButtons() {
        let viewController = GhostButtonViewController()
        viewController.title = "Ghost buttons"
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func presentRules() {
        let viewController = RulesViewController()
        viewController.title = "Rules"
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func presentOtherButton() {
        let viewController = OtherButtonsViewController()
        viewController.title = "Other buttons"
        navigationController?.pushViewController(viewController, animated: true)
    }
}
