//
//  ControlCellView.swift
//  ExampleiOS
//
//  Created on 11.11.2020.
//

import UIKit
import AdmiralUIKit
import AdmiralTheme

final class ControlCellView<T>: UIView, AnyAppThemable where T: UIView {

    // MARK: - Private Properties
    
    let textField: T
    let statuses: [String]
    let segmentControl = StandardSegmentedControl(frame: .zero)
    var changeStateAction: ((TextInputState) -> Void)?
    
    // MARK: - Initializer

    init(textField: T, statuses: [String]) {
        self.textField = textField
        self.statuses = statuses
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - AnyAppThemable
    
    func apply(theme: AppTheme) {
        segmentControl.apply(theme: theme)
        (textField as? AppThemeCompatible)?.apply(theme: theme)
    }
    
    private func commonInit() {
        apply(theme: Appearance.shared.theme)
        
        addSubviews()
        configureLayout()
        configureUI()
    }
    
    private func addSubviews() {
        textField.translatesAutoresizingMaskIntoConstraints = false
        addSubview(textField)
        
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        addSubview(segmentControl)
    }
    
    private func configureLayout() {
        configureTextFieldLayout()
        configureSegmentControlLayout()
    }
    
    private func configureTextFieldLayout() {
        let top = textField.topAnchor.constraint(equalTo: segmentControl.bottomAnchor, constant: LayoutGrid.tripleModule)
        let leading = textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutGrid.doubleModule)
        let trailing = trailingAnchor.constraint(equalTo: textField.trailingAnchor, constant: LayoutGrid.doubleModule)
        let bottom = bottomAnchor.constraint(equalTo: textField.bottomAnchor, constant: LayoutGrid.module)
        
        NSLayoutConstraint.activate([top, bottom, leading, trailing])
    }
    
    private func configureSegmentControlLayout() {
        let top = segmentControl.topAnchor.constraint(equalTo: topAnchor, constant: LayoutGrid.tripleModule)
        let leading = segmentControl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutGrid.doubleModule)
        let trailing = trailingAnchor.constraint(equalTo: segmentControl.trailingAnchor, constant: LayoutGrid.doubleModule)
        
        NSLayoutConstraint.activate([top, leading, trailing])
    }
    
    private func configureUI() {
        guard !statuses.isEmpty else { return }
        
        for index in 0..<statuses.count {
            let status = statuses[index]
            segmentControl.insertTitle(status, forSegmentAt: index)
        }
        segmentControl.selectedSegmentIndex = 0
        
        segmentControl.addTarget(self, action: #selector(segmentedValueChanged(_:)), for: .valueChanged)
    }
    
    @objc private func segmentedValueChanged(_ control: StandardSegmentedControl) {
       guard let state = TextInputState(rawValue: control.selectedSegmentIndex) else {
            return
        }
        changeStateAction?(state)
    }

}
