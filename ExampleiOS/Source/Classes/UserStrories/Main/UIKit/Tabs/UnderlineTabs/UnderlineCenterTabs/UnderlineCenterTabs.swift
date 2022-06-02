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
        segmentControl.setTitles(["Default", "Disabled"])
        segmentControl.selectedSegmentIndex = 0
        segmentControl.addTarget(self, action: #selector(segmentedValueChanged), for: .valueChanged)
    }
    
    private func configureSegmentControlls() {
        let segmentControlFirst = UnderlineSegmentedControl(items: ["One", "Two"])
        segmentControlFirst.selectedSegmentIndex = 0
        segmentControlFirst.isStaticTabs = true

        let view1 = TabsView<UnderlineSegmentedControl>(segmentView: segmentControlFirst, title: "Two controls", segmentOffset: 16.0)
        
        views.append(view1)
        
        let segmentControlSecond = UnderlineSegmentedControl(items: ["One", "Two", "Three"])
        segmentControlSecond.selectedSegmentIndex = 0
        segmentControlSecond.isStaticTabs = true
        
        let view2 = TabsView<UnderlineSegmentedControl>(segmentView: segmentControlSecond, title: "Three controls", segmentOffset: 16.0)
        
        views.append(view2)
        
        let segmentControlThird = UnderlineSegmentedControl(items: ["One", "Two", "Three", "Four"])
        segmentControlThird.selectedSegmentIndex = 0
        segmentControlThird.isStaticTabs = true
        
        let view3 = TabsView<UnderlineSegmentedControl>(segmentView: segmentControlThird, title: "Four controls", segmentOffset: 16.0)
        
        views.append(view3)
        
        let segmentControlFourth = UnderlineSegmentedControl(items: ["One", "Two", "Three", "Five"])
        segmentControlFourth.selectedSegmentIndex = 0
        segmentControlFourth.isStaticTabs = true
        
        let view4 = TabsView<UnderlineSegmentedControl>(segmentView: segmentControlFourth, title: "Five controls", segmentOffset: 16.0)
        
        views.append(view4)
        
        let segmentControlFifth = UnderlineSegmentedControl(items: ["One", "Two", "Three"])
        segmentControlFifth.selectedSegmentIndex = 0
        segmentControlFifth.isStaticTabs = true
        
        let view5 = TabsView<UnderlineSegmentedControl>(segmentView: segmentControlFifth, title: "Notifications", segmentOffset: 16.0)
        
        views.append(view5)
    }
    
    @objc private func segmentedValueChanged(_ control: StandardSegmentedControl) {
        views.forEach({ $0.isEnabled = control.selectedSegmentIndex == 1 ? false : true })
    }
    
}
