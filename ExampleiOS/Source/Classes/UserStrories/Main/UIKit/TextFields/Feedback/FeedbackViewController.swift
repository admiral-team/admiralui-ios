//
//  FeedbackViewController.swift
//  ExampleiOS
//
//  Created on 03.11.2020.
//

import AdmiralUIKit
import AdmiralTheme
import UIKit

final class FeedbackViewController: BaseViewController {

    let digitControl = FeedbackInputControl()
    let segmentControl = StandardSegmentedControl(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - AnyAppThemable
    
    override func apply(theme: AppTheme) {
        super.apply(theme: theme)
        digitControl.apply(theme: theme)
        segmentControl.apply(theme: theme)
    }
    
    // MARK: - Private Methods
    
    private func configureUI() {
        autoManage()
    
        addSubviews()
        configureSegment()
        configureConstraints()

        digitControl.addTarget(self, action: #selector(feedbackChanged(_:)), for: .valueChanged)
        digitControl.accessibilityIdentifier = "FeedbackInputControl"
    }
    
    @objc private func stepperValueChanged(_ stepper: UIStepper) {
        digitControl.itemsCount = Int(stepper.value)
    }
    
    private func configureSegment() {
        segmentControl.selectedSegmentIndex = 0
        segmentControl.insertTitle("Default", forSegmentAt: 0)
        segmentControl.insertTitle("Disabled", forSegmentAt: 1)
        segmentControl.addTarget(self, action: #selector(segmentedValueChanged(_:)), for: .valueChanged)
    }
    
    private func addSubviews() {
        [digitControl, segmentControl].addToSuperview(view)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            digitControl.topAnchor.constraint(equalTo: segmentControl.bottomAnchor, constant: LayoutGrid.module * 6),
            digitControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            segmentControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutGrid.doubleModule),
            segmentControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -LayoutGrid.doubleModule)
        ])
        
        NSLayoutConstraint.activate([
            segmentControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: LayoutGrid.tripleModule)
        ])
    }
    
    @objc private func segmentedValueChanged(_ control: StandardSegmentedControl) {
        digitControl.isEnabled = control.selectedSegmentIndex == 0 ? true : false
    }

    @objc private func feedbackChanged(_ control: FeedbackInputControl) {}
}
