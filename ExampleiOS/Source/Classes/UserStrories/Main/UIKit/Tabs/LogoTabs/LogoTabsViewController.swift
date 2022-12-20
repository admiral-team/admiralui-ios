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
        segmentControl.setItems([
        StandardSegmentedItem(title: "Default", accesibilityId: "SegmentControlDefault"),
        StandardSegmentedItem(title: "Disabled", accesibilityId: "SegmentControlDisabled")])
        segmentControl.selectedSegmentIndex = 0
        segmentControl.addTarget(self, action: #selector(segmentedValueChanged), for: .valueChanged)
    }

    private func configureSegmentControlls() {
        let segmentControl1 = LogoTab(
            items: [
                .init(image: Asset.Tabs.visaLogo.image, accesibilityId: "LogoTabOne1"),
                .init(image: Asset.Tabs.masterCardLogo.image, accesibilityId: "LogoTabOne2")
            ]
        )
        segmentControl1.selectedSegmentIndex = 0

        let view1 = TabsView<LogoTab>(segmentView: segmentControl1, title: "Two controls")
        views.append(view1)
        
        let segmentControl2 = LogoTab(
            items: [
                .init(image: Asset.Tabs.visaLogo.image, accesibilityId: "LogoTabTwo1"),
                .init(image: Asset.Tabs.masterCardLogo.image, accesibilityId: "LogoTabTwo2"),
                .init(image: Asset.Tabs.mirLogo.image, accesibilityId: "LogoTabTwo3")
            ]
        )
        segmentControl2.selectedSegmentIndex = 0

        let view2 = TabsView<LogoTab>(segmentView: segmentControl2, title: "Three controls")
        views.append(view2)

        let segmentControl3 = LogoTab(
            items: [
                .init(image: Asset.Tabs.visaLogo.image, accesibilityId: "LogoTabThree1"),
                .init(image: Asset.Tabs.masterCardLogo.image, accesibilityId: "LogoTabThree2"),
                .init(image: Asset.Tabs.mirLogo.image, accesibilityId: "LogoTabThree3"),
                .init(image: Asset.Card.applePay.image, accesibilityId: "LogoTabThree4")
            ]
        )
        segmentControl3.selectedSegmentIndex = 0

        let view3 = TabsView<LogoTab>(segmentView: segmentControl3, title: "Four controls")
        views.append(view3)

        let segmentControl4 = LogoTab(
            items: [
                .init(image: Asset.Tabs.visaLogo.image, accesibilityId: "LogoTabFour1"),
                .init(image: Asset.Tabs.masterCardLogo.image, accesibilityId: "LogoTabFour2"),
                .init(image: Asset.Tabs.mirLogo.image, accesibilityId: "LogoTabFour3"),
                .init(image: Asset.Card.applePay.image, accesibilityId: "LogoTabFour4"),
                .init(image: Asset.Card.googlePay.image, accesibilityId: "LogoTabFour5")
            ]
        )
        segmentControl4.selectedSegmentIndex = 0

        let view4 = TabsView<LogoTab>(segmentView: segmentControl4, title: "Five controls")
        views.append(view4)
    }
    
    @objc private func segmentedValueChanged(_ control: StandardSegmentedControl) {
        views.forEach({ $0.isEnabled = control.selectedSegmentIndex == 1 ? false : true })
    }
 
}
