//
//  IconTabsViewController.swift
//  ExampleiOS
//
//  Created on 15.02.2021.
//

import AdmiralUIKit
import AdmiralTheme
import UIKit

final class IconTabsViewController: ScrollViewController {
    
    // MARK: - Private Properties
    
    private var views = [TabsView<IconTabsSegmentControl>]()
    
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
        let segmentControl1 = IconTabsSegmentControl(
            items: [
                IconTab(title: "One", image: Asset.IconTabs.mobile.image, accesibilityId: "IconTabOne1"),
                IconTab(title: "Two", image: Asset.IconTabs.card.image, accesibilityId: "IconTabOne2")
            ]
        )
        segmentControl1.selectedSegmentIndex = 0
        
        let view1 = TabsView<IconTabsSegmentControl>(segmentView: segmentControl1, title: "Two controls")
        views.append(view1)
        
        let segmentControl2 = IconTabsSegmentControl(
            items: [
                IconTab(title: "One", image: Asset.IconTabs.mobile.image, accesibilityId: "IconTabTwo1"),
                IconTab(title: "Two", image: Asset.IconTabs.card.image, accesibilityId: "IconTabTwo2"),
                IconTab(title: "Three", image: Asset.IconTabs.account.image, accesibilityId: "IconTabTwo3")
            ]
        )
        segmentControl2.selectedSegmentIndex = 0
        
        let view2 = TabsView<IconTabsSegmentControl>(segmentView: segmentControl2, title: "Three controls")
        views.append(view2)
    }
    
    @objc private func segmentedValueChanged(_ control: StandardSegmentedControl) {
        views.forEach({ $0.isEnabled = control.selectedSegmentIndex == 1 ? false : true })
    }

}
