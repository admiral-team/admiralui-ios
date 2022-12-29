//
//  OutlineSliderTabsViewController.swift
//  ExampleiOS
//
//  Created on 10.02.2021.
//

import AdmiralUIKit
import AdmiralTheme
import UIKit

final class OutlineSliderTabsViewController: ScrollViewController {
    
    // MARK: - Private Properties
    
    private var views = [TabsView<OutlineSliderTabSegmentedControl>]()
    
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
        views.forEach() { stackView.addArrangedSubview($0) }
        segmentControl.setItems([
        StandardSegmentedItem(title: "Default", accesibilityId: "SegmentControlDefault"),
        StandardSegmentedItem(title: "Disabled", accesibilityId: "SegmentControlDisabled")])
        segmentControl.selectedSegmentIndex = 0
        segmentControl.addTarget(self, action: #selector(segmentedValueChanged), for: .valueChanged)
    }

    private func configureSegmentControlls() {
        let segmentControlFirst = OutlineSliderTabSegmentedControl(
            items: [
                .init(title: "One", badgeStyle: nil, accesibilityId: "OutlineSliderTabOne1"),
                .init(title: "Two", badgeStyle: nil, accesibilityId: "OutlineSliderTabOne2"),
                .init(title: "Three", badgeStyle: nil, accesibilityId: "OutlineSliderTabOne3")
            ]
        )
        segmentControlFirst.selectedSegmentIndex = 0
        segmentControlFirst.contentInset = UIEdgeInsets(
            top: 0.0,
            left: LayoutGrid.doubleModule,
            bottom: 0.0,
            right: LayoutGrid.doubleModule)
        
        let viewFirst = TabsView<OutlineSliderTabSegmentedControl>(segmentView: segmentControlFirst, title: "Three controls", segmentOffset: 0.0)
        views.append(viewFirst)
        
        let segmentControlSecond = OutlineSliderTabSegmentedControl(
            items: [
                .init(title: "One", badgeStyle: nil, accesibilityId: "OutlineSliderTabTwo1"),
                .init(title: "Two", badgeStyle: nil, accesibilityId: "OutlineSliderTabTwo2"),
                .init(title: "Three", badgeStyle: nil, accesibilityId: "OutlineSliderTabTwo3"),
                .init(title: "Four", badgeStyle: nil, accesibilityId: "OutlineSliderTabTwo4"),
                .init(title: "Five", badgeStyle: nil, accesibilityId: "OutlineSliderTabTwo5"),
                .init(title: "Six", badgeStyle: nil, accesibilityId: "OutlineSliderTabTwo6"),
                .init(title: "Seven", badgeStyle: nil, accesibilityId: "OutlineSliderTabTwo7"),
                .init(title: "Eight", badgeStyle: nil, accesibilityId: "OutlineSliderTabTwo8"),
                .init(title: "Nine", badgeStyle: nil, accesibilityId: "OutlineSliderTabTwo9")
            ]
        )
        segmentControlSecond.selectedSegmentIndex = 0
        segmentControlSecond.isScrollEnabled = true
        segmentControlSecond.contentInset = UIEdgeInsets(
            top: 0.0,
            left: LayoutGrid.doubleModule,
            bottom: 0.0,
            right: LayoutGrid.doubleModule)
        let viewSecond = TabsView<OutlineSliderTabSegmentedControl>(segmentView: segmentControlSecond, title: "Slider controls", segmentOffset: 0.0)
        views.append(viewSecond)

        let segmentControlThird = OutlineSliderTabSegmentedControl(items: [
            OutlineSliderTabItem(
                title: "One", badgeStyle: .default, accesibilityId: "OutlineSliderTabThree1"
            ),
            OutlineSliderTabItem(
                title: "Two", badgeStyle: .default, accesibilityId: "OutlineSliderTabThree2"
            ),
            OutlineSliderTabItem(
                title: "Three", badgeStyle: .natural, accesibilityId: "OutlineSliderTabThree3"
            ),
            OutlineSliderTabItem(
                title: "Four", badgeStyle: .clear, accesibilityId: "OutlineSliderTabThree4"
            )
        ])
        segmentControlThird.selectedSegmentIndex = 0
        segmentControlThird.isScrollEnabled = true
        segmentControlThird.contentInset = UIEdgeInsets(
            top: 0.0,
            left: LayoutGrid.doubleModule,
            bottom: 0.0,
            right: LayoutGrid.doubleModule)
        let viewThird = TabsView<OutlineSliderTabSegmentedControl>(segmentView: segmentControlThird, title: "Notifications", segmentOffset: 0.0)
        views.append(viewThird)
    }
    
    @objc private func segmentedValueChanged(_ control: StandardSegmentedControl) {
        views.forEach({ $0.isEnabled = control.selectedSegmentIndex == 1 ? false : true })
    }

}
