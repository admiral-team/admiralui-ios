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
        let segmentControlFirst = UnderlineSegmentedControl(items: [
            .init(title: "One", accesibilityId: "SegmentControlOne"),
            .init(title: "Two", accesibilityId: "SegmentControlTwo"),
            .init(title: "Three", accesibilityId: "SegmentControlThree")
        ])
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
                .init(title: "One", accesibilityId: "SegmentControlSecondOne"),
                .init(title: "Two", accesibilityId: "SegmentControlSecondTwo"),
                .init(title: "Three", accesibilityId: "SegmentControlSecondThree"),
                .init(title: "Four", accesibilityId: "SegmentControlSecondFour"),
                .init(title: "Five", accesibilityId: "SegmentControlSecondFive"),
                .init(title: "Six", accesibilityId: "SegmentControlSecondSix"),
                .init(title: "Seven", accesibilityId: "SegmentControlSecondSeven"),
                .init(title: "Eight", accesibilityId: "SegmentControlSecondEight"),
                .init(title: "Nine", accesibilityId: "SegmentControlSecondNine")
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
        
        let segmentControlThird = UnderlineSegmentedControl(items: [
            .init(title: "One", accesibilityId: "SegmentControlThirdOne"),
            .init(title: "Two", accesibilityId: "SegmentControlThirdTwo"),
            .init(title: "Three", accesibilityId: "SegmentControlThirdThree"),
            .init(title: "Four", accesibilityId: "SegmentControlThirdFour")
        ])
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
