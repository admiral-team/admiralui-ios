//
//  TextFieldsViewController.swift
//  Example iOS
//
//  Created on 15.10.2020.
//

import AdmiralUIKit
import UIKit

final class TextFieldsViewController: BaseTableViewController {
    
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
                didSelect: { [weak self] in self?.presentTextFieldsStandard() }),
            
            MainTitleTableViewCellViewModel(
                title: "Double",
                didSelect: { [weak self] in self?.presentDouble() }),
            
            MainTitleTableViewCellViewModel(
                title: "Slider",
                didSelect: { [weak self] in self?.presentSlider() }),
            
            MainTitleTableViewCellViewModel(
                title: "Card Number",
                didSelect: { [weak self] in self?.presentCardNumber() }),
            
            MainTitleTableViewCellViewModel(
                title: "SMS Code",
                didSelect: { [weak self] in self?.presentSMSCode() }),
            
            MainTitleTableViewCellViewModel(
                title: "Number",
                didSelect: { [weak self] in self?.presentNumber() }),
            
            MainTitleTableViewCellViewModel(
                title: "Feedback",
                didSelect: { [weak self] in self?.presentFeedback() }),
  
            MainTitleTableViewCellViewModel(
                title: "Pincode",
                didSelect: { [weak self] in self?.presentPincode() })
        ]
        
        return [MainSectionViewModel(items: items)]
    }
    
    private func presentTextFieldsStandard() {
        let viewController = StandardVSIconMenuViewController()
        viewController.title = "Standard"
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func presentDouble() {
        let viewController = DoubleTextFieldViewController()
        viewController.title = "Double"
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func presentSlider() {
        let viewController = SliderViewController()
        viewController.title = "Slider"
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
    
    private func presentNumber() {
        let viewController = NumberViewController()
        viewController.title = "Number"
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func presentFeedback() {
        let viewController = FeedbackViewController()
        viewController.title = "Feedback"
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func presentPincode() {
        let viewController = PinCodeViewController()
        viewController.title = "Pincode"
        navigationController?.pushViewController(viewController, animated: true)
    }
}
