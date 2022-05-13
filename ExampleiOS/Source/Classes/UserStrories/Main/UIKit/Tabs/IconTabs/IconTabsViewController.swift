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

    private let viewModel = IconTabsViewModel()
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
        segmentControl.setTitles(viewModel.tabs)
        segmentControl.selectedSegmentIndex = 0
        segmentControl.addTarget(self, action: #selector(segmentedValueChanged), for: .valueChanged)
    }
    
    private func configureSegmentControlls() {
        viewModel.items.forEach {
            let control = IconTabsSegmentControl(items: $0.items)
            control.selectedSegmentIndex = $0.selection
            let view = TabsView<IconTabsSegmentControl>(segmentView: control, title: $0.text)
            views.append(view)
        }
    }
    
    @objc private func segmentedValueChanged(_ control: StandardSegmentedControl) {
        views.forEach({ $0.isEnabled = control.selectedSegmentIndex == 1 ? false : true })
    }
 
}
