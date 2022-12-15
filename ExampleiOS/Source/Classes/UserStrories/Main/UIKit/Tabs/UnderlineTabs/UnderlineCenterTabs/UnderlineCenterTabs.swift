//
//  UnderlineCenterTabs.swift
//  ExampleiOS
//
//  Created on 30.05.2022.
//

import AdmiralUIKit
import AdmiralTheme
import UIKit

final class UnderlineCenterTabsViewController: ScrollViewController {
    
    // MARK: - Private Properties
    
    private var views = [TabsView<UnderlineSegmentedControl>]()
    
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
        let segmentControlFirst = UnderlineSegmentedControl(
            items: [
                .init(title: "One", accesibilityId: "UnderlineCenterSegmentedOne1"),
                .init(title: "Two", accesibilityId: "UnderlineCenterSegmentedOne2")
            ]
        )
        segmentControlFirst.selectedSegmentIndex = 0
        segmentControlFirst.isStaticTabs = true

        let view1 = TabsView<UnderlineSegmentedControl>(segmentView: segmentControlFirst, title: "Two controls", segmentOffset: 16.0)
        
        views.append(view1)
        
        let segmentControlSecond = UnderlineSegmentedControl(
            items: [
                .init(title: "One", accesibilityId: "UnderlineCenterSegmentedTwo1"),
                .init(title: "Two", accesibilityId: "UnderlineCenterSegmentedTwo2"),
                .init(title: "Three", accesibilityId: "UnderlineCenterSegmentedTwo3")
            ]
        )
        segmentControlSecond.selectedSegmentIndex = 0
        segmentControlSecond.isStaticTabs = true
        
        let view2 = TabsView<UnderlineSegmentedControl>(segmentView: segmentControlSecond, title: "Three controls", segmentOffset: 16.0)
        
        views.append(view2)
        
        let segmentControlThird = UnderlineSegmentedControl(
            items: [
                .init(title: "One", accesibilityId: "UnderlineCenterSegmentedThree1"),
                .init(title: "Two", accesibilityId: "UnderlineCenterSegmentedThree2"),
                .init(title: "Three", accesibilityId: "UnderlineCenterSegmentedThree3"),
                .init(title: "Four", accesibilityId: "UnderlineCenterSegmentedThree4")
            ]
        )
        segmentControlThird.selectedSegmentIndex = 0
        segmentControlThird.isStaticTabs = true
        
        let view3 = TabsView<UnderlineSegmentedControl>(segmentView: segmentControlThird, title: "Four controls", segmentOffset: 16.0)
        
        views.append(view3)
        
        let segmentControlFourth = UnderlineSegmentedControl(
            items: [
                .init(title: "One", accesibilityId: "UnderlineCenterSegmentedFour1"),
                .init(title: "Two", accesibilityId: "UnderlineCenterSegmentedFour2"),
                .init(title: "Three", accesibilityId: "UnderlineCenterSegmentedFour3"),
                .init(title: "Four", accesibilityId: "UnderlineCenterSegmentedFour4"),
                .init(title: "Five", accesibilityId: "UnderlineCenterSegmentedFour5")
            ]
        )
        segmentControlFourth.selectedSegmentIndex = 0
        segmentControlFourth.isStaticTabs = true
        
        let view4 = TabsView<UnderlineSegmentedControl>(segmentView: segmentControlFourth, title: "Five controls", segmentOffset: 16.0)
        
        views.append(view4)
        
        let segmentControlFifth = UnderlineSegmentedControl(
            items: [
                .init(title: "One", accesibilityId: "UnderlineCenterSegmentedFive1"),
                .init(title: "Two", accesibilityId: "UnderlineCenterSegmentedFive2"),
                .init(title: "Three", accesibilityId: "UnderlineCenterSegmentedFive3")
            ]
        )
        segmentControlFifth.selectedSegmentIndex = 0
        segmentControlFifth.isStaticTabs = true
        
        let view5 = TabsView<UnderlineSegmentedControl>(segmentView: segmentControlFifth, title: "Notifications", segmentOffset: 16.0)
        
        views.append(view5)
    }
    
    @objc private func segmentedValueChanged(_ control: StandardSegmentedControl) {
        views.forEach({ $0.isEnabled = control.selectedSegmentIndex == 1 ? false : true })
    }
    
}
