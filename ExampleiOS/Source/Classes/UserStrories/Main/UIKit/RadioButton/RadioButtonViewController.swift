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
        configureCheckBoxViews()
        
        views.forEach() {
            stackView.addArrangedSubview($0)
        }
        segmentControl.setTitles(["Default", "Disabled"])
        segmentControl.selectedSegmentIndex = 0
        segmentControl.addTarget(self, action: #selector(segmentedValueChanged), for: .valueChanged)
    }

    private func configureCheckBoxViews() {
        let defaultRadioButtonView = RadioControlsCellView(
            textCheckboxTitle: "Text",
            checkBoxesControlState: .normal,
            isSelected: false,
            titleText: "Default")
        views.append(defaultRadioButtonView)
        
        let selectedRadioButtonView = RadioControlsCellView(
            textCheckboxTitle: "Text",
            checkBoxesControlState: .normal,
            isSelected: true,
            titleText: "Selected")
        views.append(selectedRadioButtonView)
        
        let errorRadioButtonView = RadioControlsCellView(
            textCheckboxTitle: "Text",
            checkBoxesControlState: .error,
            isSelected: false,
            titleText: "Error")
        views.append(errorRadioButtonView)
    }
    
    @objc private func segmentedValueChanged(_ control: StandardSegmentedControl) {
        views.forEach({ $0.isEnabled = control.selectedSegmentIndex == 1 ? false : true })
    }
 
}
