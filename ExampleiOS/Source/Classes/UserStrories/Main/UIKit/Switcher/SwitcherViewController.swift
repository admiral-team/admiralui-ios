//
//  SwitcherMenuViewController.swift
//  ExampleiOS
//
//  Created on 09.11.2020.
//

import UIKit
import AdmiralUIKit

final class SwitcherViewController: ScrollViewController {
    
    // MARK: - Private Properties
    
    private var views = [SwitcherCellView]()
    private let viewModel = SwitcherViewModel()
    
    // MARK: - Initializers

    override func viewDidLoad() {
        super.viewDidLoad()
        hideSegmentView(false)
        
        configureUI()
    }
    
    // MARK: - Private Methods
    
    private func configureUI() {
        configureSwithes()
        
        views.forEach() {
            stackView.addArrangedSubview($0)
        }
        segmentControl.setTitles(viewModel.tabItems)
        segmentControl.selectedSegmentIndex = 0
        segmentControl.addTarget(self, action: #selector(segmentedValueChanged), for: .valueChanged)
    }
    
    private func configureSwithes() {
        viewModel.items.forEach {
            views.append(SwitcherCellView(isOn: $0.isEnabled, title: $0.text))
        }
    }
    
    @objc private func segmentedValueChanged(_ control: StandardSegmentedControl) {
        views.forEach({ $0.isEnabled = control.selectedSegmentIndex == 1 ? false : true })
    }
    
}
