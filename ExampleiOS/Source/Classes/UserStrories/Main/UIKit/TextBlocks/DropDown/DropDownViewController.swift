//
//  DropDownViewController.swift
//  ExampleiOS
//
//  Created on 24.02.2022.
//

import UIKit
import AdmiralUIKit
import AdmiralTheme

final class DropDownViewController: ScrollViewController {
    
    var headers: [UIView] = []
    
    // MARK: - Initializers
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideSegmentView(false)
        configureUI()
    }
    
    override func apply(theme: AppTheme) {
        super.apply(theme: theme)
        headers.forEach({ ($0 as? AppThemeCompatible)?.apply(theme: theme) })
    }
    
    // MARK: - Private Methods
    
    private func configureUI() {
        stackView.spacing = LayoutGrid.halfModule * 3
        
        headers.append(TitleButtonDropDown(title: "Title", buttonTitle: "Button", dropDownHeaderType: .down))
        headers.append(ButtonDropDown(buttonTitle: "Button", dropDownHeaderType: .down))
        
        headers.forEach() {
            $0.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview($0)
        }
        
        segmentControl.setItems([
        StandardSegmentedItem(title: "Default", accesibilityId: "SegmentControlDefault"),
        StandardSegmentedItem(title: "Disabled", accesibilityId: "SegmentControlDisabled")])
        segmentControl.selectedSegmentIndex = 0
        segmentControl.addTarget(self, action: #selector(segmentedValueChanged), for: .valueChanged)
    }
    
    @objc private func segmentedValueChanged(_ control: StandardSegmentedControl) {
        headers.forEach({
            if let button = $0 as? TitleButtonDropDown {
                button.isEnabled = control.selectedSegmentIndex == 1 ? false : true
            }
            
            if let button = $0 as? ButtonDropDown {
                button.isEnabled = control.selectedSegmentIndex == 1 ? false : true
            }
        })
    }
    
}
