//
//  PinCodeViewController.swift
//  ExampleiOS
//
//  Created on 03.11.2020.
//

import AdmiralUIKit
import AdmiralTheme
import AdmiralUIResources
import UIKit

final class PinCodeViewController: UIViewController, CodeInputControlDelegate, AnyAppThemable {

    let pincodeControl = PinCodeInput()
    let segmentControl = StandardSegmentedControl(frame: .zero)
    let stepper = InputNumber()
    let pinCodeKeyboard = PinCodeKeyboard()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - AnyAppThemable
    
    func apply(theme: AppTheme) {
        stepper.apply(theme: theme)
        pincodeControl.apply(theme: theme)
        segmentControl.apply(theme: theme)
        pinCodeKeyboard.apply(theme: theme)
        view.backgroundColor = theme.colors.backgroundBasic.uiColor
    }
    
    // MARK: - Private Methods
    
    private func configureUI() {
        autoManage()

        stepper.minimumValue = 1
        stepper.value = 4
        stepper.maximumValue = 10
        stepper.text = "Количество знаков"
        stepper.addTarget(self, action: #selector(stepperValueChanged(_:)), for: .valueChanged)
        
        segmentControl.insertTitle("Default", forSegmentAt: 0)
        segmentControl.insertTitle("Success", forSegmentAt: 1)
        segmentControl.insertTitle("Error", forSegmentAt: 2)
        segmentControl.selectedSegmentIndex = 0
        segmentControl.addTarget(self, action: #selector(segmentedValueChanged(_:)), for: .valueChanged)
        
        pinCodeKeyboard.delegate = self
        
        addSubviews()
        configureConstraints()
    }
    
    @objc private func segmentedValueChanged(_ control: StandardSegmentedControl) {
        guard let status = CodeInputControl.Status(rawValue: control.selectedSegmentIndex) else {
            return
        }
        pincodeControl.status = status
    }
    
    @objc private func stepperValueChanged(_ stepper: InputNumber) {
        pincodeControl.itemsCount = Int(stepper.value)
    }
    
    private func addSubviews() {
        [pincodeControl, segmentControl, stepper, pinCodeKeyboard].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            pincodeControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            segmentControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutGrid.doubleModule),
            segmentControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -LayoutGrid.doubleModule),
            pincodeControl.topAnchor.constraint(equalTo: stepper.bottomAnchor, constant: LayoutGrid.module * 4),
            
            view.trailingAnchor.constraint(equalTo: stepper.trailingAnchor, constant: LayoutGrid.doubleModule),
            stepper.topAnchor.constraint(equalTo: segmentControl.bottomAnchor, constant: LayoutGrid.tripleModule),
            stepper.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LayoutGrid.doubleModule),
            stepper.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -LayoutGrid.doubleModule),
            
            pinCodeKeyboard.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pinCodeKeyboard.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pinCodeKeyboard.heightAnchor.constraint(equalToConstant: LayoutGrid.doubleModule * 22)
        ])
        
        NSLayoutConstraint.activate([
            segmentControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: LayoutGrid.tripleModule),
            pinCodeKeyboard.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
}

extension PinCodeViewController: PinCodeKeyboardDelegate {
    
    func pincodeViewDidTapItem(_ view: PinCodeKeyboard, text: String) {
        pincodeControl.insertText(text)
        if pincodeControl.text.count > 0 {
            view.rightButtonImage = Asset.PinCode.deleteButton.image
        } else {
            view.rightButtonImage = AdmiralUIResources.Asset.Security.Outline.faceIDOutline.image
        }
    }
    
    func pincodeViewDidTapLeftAccessoryItem(_ view: PinCodeKeyboard) {
        print("Не могу войти")
    }
    
    func pincodeViewDidTapRightAccessoryItem(_ view: PinCodeKeyboard) {
        if pincodeControl.text.count > 0 {
            pincodeControl.deleteBackward()
            if pincodeControl.text.count == 0 {
                view.rightButtonImage = AdmiralUIResources.Asset.Security.Outline.faceIDOutline.image
            }
        } 
    }
    
}
