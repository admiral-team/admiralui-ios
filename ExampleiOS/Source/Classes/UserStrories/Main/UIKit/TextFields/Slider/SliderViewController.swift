//
//  SliderViewController.swift
//  ExampleiOS
//
//  Created on 10.11.2020.
//

import AdmiralUIKit
import AdmiralTheme
import UIKit

final class SliderViewController: ScrollViewController {
    
    var views: [UIView] = []
    
    // MARK: - Initializers
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideSegmentView(false)
        configureUI()
    }
    
    override func apply(theme: AppTheme) {
        super.apply(theme: theme)
        views.forEach({ ($0 as? AppThemeCompatible)?.apply(theme: theme) })
    }
    
    // MARK: - Private Methods
    
    private func configureUI() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTap))
        tap.cancelsTouchesInView = false
        scrollView.addGestureRecognizer(tap)
        
        configureSegmentControl()
        configureTextFields()
        
        views.forEach() {
            $0.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview($0)
        }
    }
    
    private func configureSegmentControl() {
        segmentControl.setTitles(["Default", "Error", "Disabled"])
        segmentControl.selectedSegmentIndex = 0
        segmentControl.addTarget(self, action: #selector(segmentedValueChanged), for: .valueChanged)
    }
    
    private func configureTextFields() {
        let textFieldSix = createInputRangeTextFieldView(
            name: "Optional label",
            text: "Text",
            info: "Additional text")
        
        let doubleFieldSix = createDoubleInputRangeTextFieldView(
            name: "Optional label",
            text: "Text",
            info: "Additional text")
        views.append(textFieldSix)
        views.append(doubleFieldSix)
    }
    
    @objc func didTap() {
        view.endEditing(true)
    }
    
    private func createInputRangeTextFieldView(
        name: String? = nil,
        text: String? = nil,
        placeholder: String? = nil,
        info: String? = nil
    ) -> ControlCellView<InputRangeTextField> {
        
        let inputRangeTextField = InputRangeTextField()
        inputRangeTextField.name = name
        inputRangeTextField.info = info
        inputRangeTextField.minimumValue = 10
        inputRangeTextField.maximumValue = 1000
        inputRangeTextField.leadingText = "₽"
        inputRangeTextField.placeholder = placeholder ?? "10"
        inputRangeTextField.text = String(Int(inputRangeTextField.value))
        inputRangeTextField.keyboardType = .numberPad
        inputRangeTextField.accessibilityIdentifier = "InputRangeTextField"
        inputRangeTextField.setAccessibilityidentifiers(
            textFieldId: "InputRangeTextFieldInput",
            sliderThubmImageId: "InputRangeTextFieldSliderThubmImage",
            sliderProgressViewId: "InputRangeTextFieldSliderProgressView"
        )
        
        let cell = ControlCellView<InputRangeTextField>(textField: inputRangeTextField, titleText: "Standard")
        
        return cell
    }
    
    private func createDoubleInputRangeTextFieldView(
        name: String? = nil,
        text: String? = nil,
        minTextPlaceholder: String? = nil,
        maxTextPlaceholder: String? = nil,
        info: String? = nil
    ) -> ControlCellView<DoubleInputRangeTextField> {
        
        let doubleInputRangeTextField = DoubleInputRangeTextField()
        doubleInputRangeTextField.name = name
        doubleInputRangeTextField.minTextPlaceholder = minTextPlaceholder
        doubleInputRangeTextField.maxTextPlaceholder = maxTextPlaceholder
        doubleInputRangeTextField.info = info
        doubleInputRangeTextField.minimumValue = 10
        doubleInputRangeTextField.maximumValue = 1000
        doubleInputRangeTextField.lowerValue = 100
        doubleInputRangeTextField.upperValue = 500
        doubleInputRangeTextField.leadingText = "₽"
        doubleInputRangeTextField.trailingText = "₽"
        doubleInputRangeTextField.minTextPlaceholder = minTextPlaceholder ?? "10"
        doubleInputRangeTextField.maxTextPlaceholder = maxTextPlaceholder ?? "1000"
        doubleInputRangeTextField.minValueText = String(Int(doubleInputRangeTextField.lowerValue))
        doubleInputRangeTextField.maxValueText = String(Int(doubleInputRangeTextField.upperValue))
        doubleInputRangeTextField.keyboardType = .numberPad
        doubleInputRangeTextField.accessibilityIdentifier = "DoubleInputRangeTextField"
        doubleInputRangeTextField.setAccessibilityidentifiers(
            leftTextFieldId: "DoubleInputRangeLeftTextField",
            rightTextFieldId: "DoubleInputRangeRightTextField",
            doubleSliderLowerImageId: "DoubleInputRangeSliderLowerImage",
            doubleSliderUpperImageId: "DoubleInputRangeSliderUpperImage",
            doubleSliderProgressViewId: "DoubleInputRangeSliderProgressView"
        )
        
        let cell = ControlCellView<DoubleInputRangeTextField>(textField: doubleInputRangeTextField, titleText: "Double")
        
        return cell
    }
    
    @objc private func segmentedValueChanged(_ control: StandardSegmentedControl) {
        guard let state = TextInputState(rawValue: control.selectedSegmentIndex) else { return }
        views.forEach {
            if let textField = $0 as? ControlCellView<InputRangeTextField> {
                textField.textField.state = state
            } else if let textField = $0 as? ControlCellView<DoubleInputRangeTextField> {
                textField.textField.state = state
            }
        }
    }
    
}
