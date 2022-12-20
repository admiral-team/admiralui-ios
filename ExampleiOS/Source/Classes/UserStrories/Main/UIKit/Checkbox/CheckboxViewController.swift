//
//  CheckboxViewController.swift
//  ExampleiOS
//
//  Created on 09.11.2020.
//

import AdmiralUIKit
import AdmiralTheme
import UIKit

final class CheckboxViewController: ScrollViewController {
    
    // MARK: - Private Properties
    
    private enum BadgeState: Int {
        case enabled
        case disabled
    }

    private var views = [CheckBoxesCellView]()
    
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
        segmentControl.setItems([
        StandardSegmentedItem(title: "Default", accesibilityId: "SegmentControlDefault"),
        StandardSegmentedItem(title: "Disabled", accesibilityId: "SegmentControlDisabled")])
        segmentControl.selectedSegmentIndex = 0
        segmentControl.addTarget(self, action: #selector(segmentedValueChanged), for: .valueChanged)
    }

    private func configureCheckBoxViews() {
        let defaultCheckBox = CheckBoxesCellView(
            textCheckboxTitle: "Text",
            checkBoxesControlState: .normal,
            isSelected: false,
            titleText: "Default",
            firstCheckBoxAccessibilityId: "FirstCheckBoxesCellViewFirstControl",
            secondCheckBoxAccessibilityId: "FirstCheckBoxesCellViewSecondControl"
        )
        views.append(defaultCheckBox)
        
        let selectedCheckBox = CheckBoxesCellView(
            textCheckboxTitle: "Text",
            checkBoxesControlState: .normal,
            isSelected: true,
            titleText: "Selected",
            firstCheckBoxAccessibilityId: "SecondCheckBoxesCellViewFirstControl",
            secondCheckBoxAccessibilityId: "SecondCheckBoxesCellViewSecondControl"
        )
        views.append(selectedCheckBox)
        
        let errorCheckBox = CheckBoxesCellView(
            textCheckboxTitle: "Text",
            checkBoxesControlState: .error,
            isSelected: false,
            titleText: "Error",
            firstCheckBoxAccessibilityId: "ThirdCheckBoxesCellViewFirstControl",
            secondCheckBoxAccessibilityId: "ThirdCheckBoxesCellViewSecondControl"
        )
        views.append(errorCheckBox)
    }
    
    @objc private func segmentedValueChanged(_ control: StandardSegmentedControl) {
        views.forEach({ $0.isEnabled = control.selectedSegmentIndex == 1 ? false : true })
    }
 
}
