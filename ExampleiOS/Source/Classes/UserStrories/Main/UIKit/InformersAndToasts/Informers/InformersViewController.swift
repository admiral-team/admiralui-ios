//
//  InformersViewController.swift
//  ExampleiOS
//
//  Created on 23.11.2020.
//

import AdmiralUIKit
import UIKit

final class InformersViewController: BaseTableViewController {
    
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
                title: "Big Informers",
                didSelect: { [weak self] in self?.presentBigInformers() }),
            
            MainTitleTableViewCellViewModel(
                title: "Small Informers",
                didSelect: { [weak self] in self?.presentSmallInformers() })
        ]
        
        return [MainSectionViewModel(items: items)]
    }
    
    private func presentBigInformers() {
        let viewController = BigInformersController()
        viewController.title = "Big Informers"
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func presentSmallInformers() {
        let viewController = SmallInformersViewController()
        viewController.title = "Small Informers"
        navigationController?.pushViewController(viewController, animated: true)
    }

}
