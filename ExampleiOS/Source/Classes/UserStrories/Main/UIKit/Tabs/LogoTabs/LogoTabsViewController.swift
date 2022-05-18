//
//  LogoTabsViewController.swift
//  ExampleiOS
//
//  Created on 10.02.2021.
//

import AdmiralUIKit
import AdmiralTheme
import UIKit

final class LogoTabsViewController: ScrollViewController {
    
    // MARK: - Private Properties
    
    private var views = [TabsView<LogoTab>]()
    
    // MARK: - Initializers

    override func viewDidLoad() {
        super.viewDidLoad()
        hideSegmentView(false)
        
        configureUI()
    }
    
    // MARK: - AnyAppThemable
    
    override func apply(theme: AppTheme) {
        super.apply(theme: theme)
        
        views.forEach({ $0.apply(theme: theme) })
    }
    
    // MARK: - Private Methods
    
    private func configureUI() {
        configureSegmentControlls()
        
        views.forEach() {
            stackView.addArrangedSubview($0)
        }
        segmentControl.setTitles(["Default", "Disabled"])
        segmentControl.selectedSegmentIndex = 0
        segmentControl.addTarget(self, action: #selector(segmentedValueChanged), for: .valueChanged)
    }

    private func configureSegmentControlls() {
        let segmentControl1 = LogoTab(
            images: [Asset.Tabs.visaLogo.image,
                     Asset.Tabs.masterCardLogo.image])
        segmentControl1.selectedSegmentIndex = 0

        let view1 = TabsView<LogoTab>(segmentView: segmentControl1, title: "Two controls")
        views.append(view1)
        
        let segmentControl2 = LogoTab(
            images: [Asset.Tabs.visaLogo.image,
                     Asset.Tabs.masterCardLogo.image,
                     Asset.Tabs.mirLogo.image])
        segmentControl2.selectedSegmentIndex = 0

        let view2 = TabsView<LogoTab>(segmentView: segmentControl2, title: "Three controls")
        views.append(view2)

        let segmentControl3 = LogoTab(
            images: [Asset.Tabs.visaLogo.image,
                     Asset.Tabs.masterCardLogo.image,
                     Asset.Tabs.mirLogo.image,
                     Asset.Card.applePay.image
        ])
        segmentControl3.selectedSegmentIndex = 0

        let view3 = TabsView<LogoTab>(segmentView: segmentControl3, title: "Four controls")
        views.append(view3)

        let segmentControl4 = LogoTab(
            images: [Asset.Tabs.visaLogo.image,
                     Asset.Tabs.masterCardLogo.image,
                     Asset.Tabs.mirLogo.image,
                     Asset.Card.applePay.image,
                     Asset.Card.googlePay.image
        ])
        segmentControl4.selectedSegmentIndex = 0

        let view4 = TabsView<LogoTab>(segmentView: segmentControl4, title: "Five controls")
        views.append(view4)
    }
    
    @objc private func segmentedValueChanged(_ control: StandardSegmentedControl) {
        views.forEach({ $0.isEnabled = control.selectedSegmentIndex == 1 ? false : true })
    }
 
}
