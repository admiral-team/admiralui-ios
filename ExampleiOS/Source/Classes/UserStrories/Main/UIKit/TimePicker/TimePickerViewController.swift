//
//  TimePickerViewController.swift
//  ExampleiOS
//
//  Created on 17.03.2021.
//

import UIKit
import AdmiralUIKit
import AdmiralTheme

final class TimePickerViewController: ScrollViewController, AccessibilitySupport {
    
    // MARK: - AccessibilitySupport
    
    public var adjustsFontForContentSizeCategory: Bool = Appearance.isAccessabilitySupportEnabled {
        didSet { updateSchemeFonts() }
    }
    
    // MARK: - Private Properties
    
    private let timeView = TimePicker()
    private let label = UILabel()
    private var scheme = TimePickerViewControllerCustomScheme() {
        didSet { updateScheme() }
    }
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideSegmentView(false)
        commonInit()
        refreshTheme()
        
        timeView.delegate = self
        segmentControl.setTitles(["Default", "Disabled"])
        segmentControl.selectedSegmentIndex = 0
        segmentControl.addTarget(self, action: #selector(segmentedValueChanged), for: .valueChanged)
    }
    
    // MARK: - AnyAppThemable
    
    override func apply(theme: AppTheme) {
        super.apply(theme: theme)
        timeView.apply(theme: theme)
        scheme = TimePickerViewControllerCustomScheme(theme: theme)
    }
    
    private func commonInit() {
        timeView.currentTime = Date()
        addSubviews()
        configureConstraints()
        hideKeyboardWhenTappedAround()
        setupLabel()
    }
    
    private func addSubviews() {
        [label,
         timeView].forEach({
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        })
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: LayoutGrid.module * 12),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutGrid.doubleModule),
            
            timeView.centerYAnchor.constraint(equalTo: label.centerYAnchor),
            view.trailingAnchor.constraint(equalTo: timeView.trailingAnchor, constant: LayoutGrid.doubleModule),
            timeView.widthAnchor.constraint(equalToConstant: 70.0),
            timeView.heightAnchor.constraint(equalToConstant: 34.0)
        ])
    }
    private func setupLabel() {
        label.textAlignment = .left
        label.text = "Время"
    }
    
    private func updateScheme() {
        updateSchemeFonts()
        updateSchemeColors()
    }
    
    private func updateSchemeFonts() {
        label.setDynamicFont(
            font: scheme.titleLabelFont.uiFont,
            textStyle: scheme.titleLabelFont.textStyle,
            adjustsFontForContentSize: adjustsFontForContentSizeCategory)
    }
    
    private func updateSchemeColors() {
        label.textColor = scheme.titleLabelTextColor.uiColor
    }
    
    @objc override func dismissKeyboard() {
        super.dismissKeyboard()
        timeView.isSelected = false
    }
    
    @objc private func segmentedValueChanged(_ control: StandardSegmentedControl) {
        timeView.isEnabled = control.selectedSegmentIndex == 1 ? false : true
        label.isEnabled = control.selectedSegmentIndex == 1 ? false : true
    }
    
}

// MARK: - TimePickerDelegate

extension TimePickerViewController: TimePickerDelegate {
    
    func timePickerDateDidChange(timePicker: TimePicker, currentTime: Date) {
        print(currentTime.toString(format: "HH:mm"))
    }
    
}

extension Date {
    
    func toString(format: String = "yyyy-MM-dd") -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
}
