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
    
    var views = [SwitcherCellView]()
    
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
        segmentControl.setItems([
        StandardSegmentedItem(title: "Default", accesibilityId: "SegmentControlDefault"),
        StandardSegmentedItem(title: "Disabled", accesibilityId: "SegmentControlDisabled")])
        segmentControl.selectedSegmentIndex = 0
        segmentControl.addTarget(self, action: #selector(segmentedValueChanged), for: .valueChanged)
    }
    
    private func configureSwithes() {
        let onSwitch = SwitcherCellView(isOn: true, title: "On", accesibilityId: "SwitcherOne")
        views.append(onSwitch)
        
        let offSwitch = SwitcherCellView(isOn: false, title: "Off", accesibilityId: "SwitcherTwo")
        views.append(offSwitch)
    }
    
    @objc private func segmentedValueChanged(_ control: StandardSegmentedControl) {
        views.forEach({ $0.isEnabled = control.selectedSegmentIndex == 1 ? false : true })
    }
    
}
