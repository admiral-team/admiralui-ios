//
//  InformerTabViewController.swift
//  ExampleiOS
//
//  Created on 10.02.2021.
//

import AdmiralUIKit
import AdmiralTheme
import UIKit

final class InformerTabViewController: ScrollViewController {
    
    // MARK: - Private Properties
    
    private var views = [BigTabsView<InformerTabSegmentedControl>]()
    
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
        let segmentConstol1 = InformerTabSegmentedControl(
            items: [
                InformerTab(title: "2 900 ₽", subtitle: "в месяц", accesibilityId: "InformerTabOne1"),
                InformerTab(title: "2 900 ₽", subtitle: "в месяц", accesibilityId: "InformerTabOne2")
            ]
        )
        segmentConstol1.selectedSegmentIndex = 0
        
        let view1 = BigTabsView<InformerTabSegmentedControl>(segmentView: segmentConstol1, title: "Two controls")
        
        views.append(view1)
        
        let segmentConstol2 = InformerTabSegmentedControl(
            items: [
                InformerTab(title: "2 900 ₽", subtitle: "в месяц", accesibilityId: "InformerTabTwo1"),
                InformerTab(title: "2 900 ₽", subtitle: "в месяц", accesibilityId: "InformerTabTwo2"),
                InformerTab(title: "2 900 ₽", subtitle: "в месяц", accesibilityId: "InformerTabTwo3")
            ]
        )
        segmentConstol2.selectedSegmentIndex = 0
        
        let view2 = BigTabsView<InformerTabSegmentedControl>(segmentView: segmentConstol2, title: "Three controls")
        
        views.append(view2)
    }
    
    @objc private func segmentedValueChanged(_ control: StandardSegmentedControl) {
        views.forEach({ $0.isEnabled = control.selectedSegmentIndex == 1 ? false : true })
    }
    
}
