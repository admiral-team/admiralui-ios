//
//  TabsViewController.swift
//  ExampleiOS
//
//  Created on 10.02.2021.
//

import AdmiralUIKit
import UIKit

final class TabsViewController: BaseTableViewController {
    
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
                title: "Standard Tabs",
                didSelect: { [weak self] in self?.presentStandardTabs() }),
            
            MainTitleTableViewCellViewModel(
                title: "Logo Tabs",
                didSelect: { [weak self] in self?.presentLogoTabs() }),
            
            MainTitleTableViewCellViewModel(
                title: "Informer Tabs",
                didSelect: { [weak self] in self?.presentInformerTabs() }),
            
            MainTitleTableViewCellViewModel(
                title: "Outline Slider Tabs",
                didSelect: { [weak self] in self?.presentOutlineSliderTabs() }),
            
            MainTitleTableViewCellViewModel(
                title: "Underline Slider Tabs",
                didSelect: { [weak self] in self?.presentUnderlineSliderTabs() }),
            
            MainTitleTableViewCellViewModel(
                title: "Icon Tabs",
                didSelect: { [weak self] in self?.presentIconTabs() })
        ]
        
        return [MainSectionViewModel(items: items)]
    }
    
    private func presentStandardTabs() {
        let viewController = StandardTabsViewController()
        viewController.title = "Standard Tabs"
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func presentLogoTabs() {
        let viewController = LogoTabsViewController()
        viewController.title = "Logo Tabs"
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func presentInformerTabs() {
        let viewController = InformerTabViewController()
        viewController.title = "Informer Tabs"
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func presentOutlineSliderTabs() {
        let viewController = OutlineSliderTabsViewController()
        viewController.title = "Outline Slider Tabs"
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func presentUnderlineSliderTabs() {
        let viewController = UnderlineSliderTabsViewController()
        viewController.title = "Underline Slider Tabs"
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func presentIconTabs() {
        let viewController = IconTabsViewController()
        viewController.title = "Icon Tabs"
        navigationController?.pushViewController(viewController, animated: true)
    }

}
