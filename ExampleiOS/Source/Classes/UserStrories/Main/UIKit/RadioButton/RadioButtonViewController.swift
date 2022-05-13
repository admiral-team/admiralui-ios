//
//  RadioButtonViewController.swift
//  ExampleiOS
//
//  Created on 20.10.2020.
//

import AdmiralUIKit
import AdmiralTheme
import UIKit

final class RadioButtonViewController: ScrollViewController {
    
    // MARK: - Private Properties
    
    private enum BadgeState: Int {
        case enabled
        case disabled
    }

    private let viewModel = RadioButtonViewModel()
    private var views = [RadioControlsCellView]()
    
    // MARK: - Initializers

    override func viewDidLoad() {
        super.viewDidLoad()
        hideSegmentView(false)
        
        configureUI()
        refreshTheme()
    }
    
    // MARK: - AnyAppThemable
    
    override func apply(theme: AppTheme) {
        super.apply(theme: theme)
        
        views.forEach({ $0.apply(theme: theme) })
    }
    
    // MARK: - Private Methods
    
    private func configureUI() {
        viewModel.items.forEach {
            views.append(RadioControlsCellView(
                textCheckboxTitle: $0.textCheckboxTitle ,
                checkBoxesControlState: $0.checkBoxesControlState,
                isSelected: $0.isSelected,
                titleText: $0.titleText
            ))
        }
        
        views.forEach() {
            stackView.addArrangedSubview($0)
        }
        segmentControl.setTitles(["Default", "Disabled"])
        segmentControl.selectedSegmentIndex = 0
        segmentControl.addTarget(self, action: #selector(segmentedValueChanged), for: .valueChanged)
    }

    
    @objc private func segmentedValueChanged(_ control: StandardSegmentedControl) {
        views.forEach({ $0.isEnabled = control.selectedSegmentIndex == 1 ? false : true })
    }
 
}
