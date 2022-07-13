//
//  UnderlineTabs.swift
//  ExampleiOS
//
//  Created on 30.05.2022.
//

import AdmiralUIKit
import UIKit

final class UnderlineTabsViewController: BaseTableViewController {
    
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
                title: "Slider",
                didSelect: { [weak self] in self?.presentSliderTabs() }),
            
            MainTitleTableViewCellViewModel(
                title: "Center",
                didSelect: { [weak self] in self?.presentCenterTabs() })
        ]
        
        return [MainSectionViewModel(items: items)]
    }
    
    private func presentSliderTabs() {
        let viewController = UnderlineSliderTabsViewController()
        viewController.title = "Underline Slider Tabs"
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func presentCenterTabs() {
        let viewController = UnderlineCenterTabsViewController()
        viewController.title = "Underline Center Tabs"
        navigationController?.pushViewController(viewController, animated: true)
    }

}
