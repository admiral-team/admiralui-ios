//
//  PageControlsViewController.swift
//  ExampleiOS
//
//  Created on 21.01.2021.
//

import AdmiralUIKit
import UIKit

final class PageControlsViewController: BaseTableViewController {
    
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
                title: "Liner",
                didSelect: { [weak self] in self?.presentLinearPageCntrol() }),
            MainTitleTableViewCellViewModel(
                title: "Circle",
                didSelect: { [weak self] in self?.presentCircularPageControl() })
        ]
        
        return [MainSectionViewModel(items: items)]
    }
    
    private func presentLinearPageCntrol() {
        let viewController = LinerPageControl()
        viewController.title = "Liner"
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func presentCircularPageControl() {
        let viewController = CircularPageControlViewController()
        viewController.title = "Circle"
        navigationController?.pushViewController(viewController, animated: true)
    }

}
