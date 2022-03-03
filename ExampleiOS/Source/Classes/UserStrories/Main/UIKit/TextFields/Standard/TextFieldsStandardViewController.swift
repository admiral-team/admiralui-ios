//
//  TextFieldsStandardViewController.swift
//  ExampleiOS
//
//  Created on 10.11.2020.
//

import AdmiralUIKit
import UIKit
 
final class TextFieldsStandardViewController: BaseTableViewController {
    
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
                title: "Standard",
                didSelect: { [weak self] in self?.presentStandardVsIcon() }),
            
            MainTitleTableViewCellViewModel(
                title: "Card Number",
                didSelect: { [weak self] in self?.presentCardNumber() }),
            
            MainTitleTableViewCellViewModel(
                title: "SMS Code",
                didSelect: { [weak self] in self?.presentSMSCode() })
        ]
        
        return [MainSectionViewModel(items: items)]
    }
    
    private func presentStandardVsIcon() {
        let viewController = StandardVSIconMenuViewController()
        viewController.title = "Standard"
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func presentCardNumber() {
        let viewController = CardNumberViewController()
        viewController.title = "Card Number"
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func presentSMSCode() {
        let viewController = SMSCodeViewController()
        viewController.title = "SMS Code"
        navigationController?.pushViewController(viewController, animated: true)
    }
}
