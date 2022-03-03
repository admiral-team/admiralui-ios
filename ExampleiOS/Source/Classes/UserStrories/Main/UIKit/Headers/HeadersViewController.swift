//
//  HeadersMenuController.swift
//  ExampleiOS
//
//  Created on 24.12.2020.
//

import AdmiralUIKit
import UIKit

final class HeadersViewController: BaseTableViewController {
    
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
                title: "Card",
                didSelect: { [weak self] in self?.presentCard() })
        ]
        
        return [MainSectionViewModel(items: items)]
    }
    
    private func presentCard() {
        let viewController = CardViewController()
        viewController.title = "Card"
        navigationController?.pushViewController(viewController, animated: true)
    }

}
