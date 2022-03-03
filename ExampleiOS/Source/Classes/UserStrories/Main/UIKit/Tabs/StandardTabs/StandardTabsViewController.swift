//
//  StandardTabsViewController.swift
//  ExampleiOS
//
//  Created on 10.02.2021.
//

import AdmiralUIKit
import AdmiralTheme
import UIKit

final class StandardTabsViewController: ScrollViewController {
    
    // MARK: - Private Properties
    
    private var views = [TabsView<StandardSegmentedControl>]()
    
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
        let segmentControl1 = StandardSegmentedControl(titles: ["One", "Two"])
        segmentControl.selectedSegmentIndex = 0

        let view1 = TabsView<StandardSegmentedControl>(segmentView: segmentControl1, title: "Two controls")
        views.append(view1)
        
        let segmentControl2 = StandardSegmentedControl(titles: ["One", "Two", "Three"])
        segmentControl.selectedSegmentIndex = 0

        let view2 = TabsView<StandardSegmentedControl>(segmentView: segmentControl2, title: "Three controls")
        views.append(view2)
    }
    
    @objc private func segmentedValueChanged(_ control: StandardSegmentedControl) {
        views.forEach({ $0.isEnabled = control.selectedSegmentIndex == 1 ? false : true })
    }
 
}
