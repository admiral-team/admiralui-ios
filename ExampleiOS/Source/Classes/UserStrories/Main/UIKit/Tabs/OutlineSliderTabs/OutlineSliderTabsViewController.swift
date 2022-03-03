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
        
        views.forEach() {
            stackView.addArrangedSubview($0)
        }
        segmentControl.setTitles(["Default", "Disabled"])
        segmentControl.selectedSegmentIndex = 0
        segmentControl.addTarget(self, action: #selector(segmentedValueChanged), for: .valueChanged)
    }

    private func configureSegmentControlls() {
        let segmentControlFirst = OutlineSliderTabSegmentedControl(titles: ["One", "Two", "Three"])
        segmentControlFirst.selectedSegmentIndex = 0
        segmentControlFirst.contentInset = UIEdgeInsets(
            top: 0.0,
            left: LayoutGrid.doubleModule,
            bottom: 0.0,
            right: LayoutGrid.doubleModule)
        
        let viewFirst = TabsView<OutlineSliderTabSegmentedControl>(segmentView: segmentControlFirst, title: "Three controls", segmentOffset: 0.0)
        
        views.append(viewFirst)
        
        let segmentControlSecond = OutlineSliderTabSegmentedControl(titles:
                                                                ["One", "Two", "Three",
                                                                 "Four", "Five", "Six",
                                                                 "Seven", "Eight", "Nine"])
        segmentControlSecond.selectedSegmentIndex = 0
        segmentControlSecond.isScrollEnabled = true
        segmentControlSecond.contentInset = UIEdgeInsets(
            top: 0.0,
            left: LayoutGrid.doubleModule,
            bottom: 0.0,
            right: LayoutGrid.doubleModule)
        
        let viewSecond = TabsView<OutlineSliderTabSegmentedControl>(segmentView: segmentControlSecond, title: "Slider controls", segmentOffset: 0.0)
        
        views.append(viewSecond)
    }
    
    @objc private func segmentedValueChanged(_ control: StandardSegmentedControl) {
        views.forEach({ $0.isEnabled = control.selectedSegmentIndex == 1 ? false : true })
    }
 
}
