//
//  NotificationsViewController.swift
//  ExampleiOS
//
//  Created on 23.12.2021.
//

import AdmiralUIKit
import UIKit

final class NotificationsViewController: BaseTableViewController {
    
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
                title: "Toast",
                didSelect: { [weak self] in self?.presentToast() }),
            
            MainTitleTableViewCellViewModel(
                title: "Notifications",
                didSelect: { [weak self] in self?.presentNotifications() }),
            
            MainTitleTableViewCellViewModel(
                title: "Action",
                didSelect: { [weak self] in self?.presentAction() })
        ]
        
        return [MainSectionViewModel(items: items)]
    }
    
    private func presentToast() {
        let viewController = ToastNotificationsViewController()
        viewController.title = "Toast"
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func presentNotifications() {
        let viewController = StaticNotificationsViewController()
        viewController.title = "Notifications"
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func presentAction() {
        let viewController = ActionNotificationViewController()
        viewController.title = "Action"
        navigationController?.pushViewController(viewController, animated: true)
    }

}
