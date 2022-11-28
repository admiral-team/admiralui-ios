//
//  StaticNotificationsViewController.swift
//  ExampleiOS
//
//  Created on 23.12.2021.
//

import AdmiralUIKit
import AdmiralTheme
import UIKit

final class StaticNotificationsViewController: ScrollViewController {
    
    enum Constants {
        static let text = "At breakpoint boundaries, mini units divide the screen into a fixed master grid."
        static let linkText = "Link text"
    }
    
    // MARK: - Private Properties
    
    private var views = [StaticNotificationView]()
    
    // MARK: - Initializers
    
    override func loadView() {
        segmentControl.setItems([
        StandardSegmentedItem(title: "Default", accesibilityId: "SegmentControlDefault"),
        StandardSegmentedItem(title: "Disabled", accesibilityId: "SegmentControlDisabled")])
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideSegmentView(false)
        configureUI()
        refreshTheme()
    }
    
    // MARK: - AppThemable
    
    override func apply(theme: AppTheme) {
        super.apply(theme: theme)
        views.forEach({
            $0.apply(theme: theme)
        })
    }
    
    // MARK: - Private Methods
    
    private func configureUI() {
        configureBadgeViews()
        views.forEach() {
            stackView.addArrangedSubview($0)
        }
        stackView.distribution = .fillEqually
        segmentControl.addTarget(self, action: #selector(segmentedValueChanged), for: .valueChanged)
    }
    
    private func configureBadgeViews() {
        let firstToastView = StaticNotificationView()
        firstToastView.configureWith(
            model: StaticNotificationViewModel(title: "Default",
                                               text: Constants.text,
                                               linkText: Constants.linkText,
                                               type: .additional,
                                               imageType: .info))
        views.append(firstToastView)
        
        let secondToastView = StaticNotificationView()
        secondToastView.configureWith(
            model: StaticNotificationViewModel(title: "Success",
                                               text: Constants.text,
                                               linkText: Constants.linkText,
                                               type: .success,
                                               imageType: .success))
        views.append(secondToastView)
        
        let thirdToastView = StaticNotificationView()
        thirdToastView.configureWith(
            model: StaticNotificationViewModel(title: "Attention",
                                               text: Constants.text,
                                               linkText: Constants.linkText,
                                               type: .attention,
                                               imageType: .attention))
        views.append(thirdToastView)
        
        let fourToastView = StaticNotificationView()
        fourToastView.configureWith(
            model: StaticNotificationViewModel(title: "Error",
                                               text: Constants.text,
                                               linkText: Constants.linkText,
                                               type: .error,
                                               imageType: .error))
        views.append(fourToastView)
    }
    
    @objc private func segmentedValueChanged(_ control: StandardSegmentedControl) {
        guard let state = control.selectedSegmentIndex == 1 ? false : true else { return }
        
        views.forEach({
            $0.isEnabled = state
        })
    }
    
}
