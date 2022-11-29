//
//  UnderlineSliderTabs.swift
//  ExampleiOS
//
//  Created on 10.02.2021.
//

import AdmiralUIKit
import AdmiralTheme
import UIKit

final class UnderlineSliderTabsViewController: ScrollViewController {
    
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
        let segmentControlFirst = UnderlineSegmentedControl(
            items: [
                .init(title: "One", accesibilityId: "UnderlineSegmentedOne1"),
                .init(title: "Two", accesibilityId: "UnderlineSegmentedOne2"),
                .init(title: "Three", accesibilityId: "UnderlineSegmentedOne3")
            ]
        )
        segmentControlFirst.selectedSegmentIndex = 0
        segmentControlFirst.isScrollEnabled = false
        segmentControlFirst.contentInset = UIEdgeInsets(
            top: 0.0,
            left: LayoutGrid.doubleModule,
            bottom: 0.0,
            right: LayoutGrid.doubleModule)
        
        let view1 = TabsView<UnderlineSegmentedControl>(segmentView: segmentControlFirst, title: "Three controls", segmentOffset: 0.0)
        
        views.append(view1)
        
        let segmentControlSecond = UnderlineSegmentedControl(
            items: [
                .init(title: "One", accesibilityId: "UnderlineSegmentedTwo1"),
                .init(title: "Two", accesibilityId: "UnderlineSegmentedTwo2"),
                .init(title: "Three", accesibilityId: "UnderlineSegmentedTwo3"),
                .init(title: "Four", accesibilityId: "UnderlineSegmentedTwo4"),
                .init(title: "Five", accesibilityId: "UnderlineSegmentedTwo5"),
                .init(title: "Six", accesibilityId: "UnderlineSegmentedTwo6"),
                .init(title: "Seven", accesibilityId: "UnderlineSegmentedTwo7"),
                .init(title: "Eight", accesibilityId: "UnderlineSegmentedTwo8"),
                .init(title: "Nine", accesibilityId: "UnderlineSegmentedTwo9")
            ]
        )
        segmentControlSecond.selectedSegmentIndex = 0
        segmentControlSecond.isScrollEnabled = true
        segmentControlSecond.contentInset = UIEdgeInsets(
            top: 0.0,
            left: LayoutGrid.doubleModule,
            bottom: 0.0,
            right: LayoutGrid.doubleModule)
        
        let view2 = TabsView<UnderlineSegmentedControl>(segmentView: segmentControlSecond, title: "Slider controls", segmentOffset: 0.0)
        
        views.append(view2)
        
        let segmentControlThird = UnderlineSegmentedControl(items: ["One", "Two", "Three", "Four"])
        segmentControlThird.selectedSegmentIndex = 0
        segmentControlThird.contentInset = UIEdgeInsets(
            top: 0.0,
            left: LayoutGrid.doubleModule,
            bottom: 0.0,
            right: LayoutGrid.doubleModule)
        
        let view3 = TabsView<UnderlineSegmentedControl>(segmentView: segmentControlThird, title: "Notifications", segmentOffset: 0.0)
        
        views.append(view3)
    }
    
    @objc private func segmentedValueChanged(_ control: StandardSegmentedControl) {
        views.forEach({ $0.isEnabled = control.selectedSegmentIndex == 1 ? false : true })
    }
    
}
