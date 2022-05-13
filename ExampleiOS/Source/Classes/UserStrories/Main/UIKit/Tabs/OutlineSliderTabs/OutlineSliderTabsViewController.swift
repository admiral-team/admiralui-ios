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

    private let viewModel = OutlineSliderTabsViewModel()
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
        segmentControl.setTitles(viewModel.tabs)
        segmentControl.selectedSegmentIndex = 0
        segmentControl.addTarget(self, action: #selector(segmentedValueChanged), for: .valueChanged)
    }

    private func configureSegmentControlls() {
        viewModel.items.forEach {
            let control = OutlineSliderTabSegmentedControl(titles: $0.items)
            control.selectedSegmentIndex = $0.selection
            control.contentInset = UIEdgeInsets(
                top: 0.0,
                left: LayoutGrid.doubleModule,
                bottom: 0.0,
                right: LayoutGrid.doubleModule)
            control.isScrollEnabled = true
            let view = TabsView<OutlineSliderTabSegmentedControl>(segmentView: control, title: $0.text, segmentOffset: 0.0)
            views.append(view)
        }
    }
    
    @objc private func segmentedValueChanged(_ control: StandardSegmentedControl) {
        views.forEach({ $0.isEnabled = control.selectedSegmentIndex == 1 ? false : true })
    }
 
}
