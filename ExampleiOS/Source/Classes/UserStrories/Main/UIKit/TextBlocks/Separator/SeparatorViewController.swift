//
//  SeparatorViewController.swift
//  ExampleiOS
//
//  Created on 12.07.2022.
//

import UIKit
import AdmiralUIKit
import AdmiralTheme

class SeparatorViewController: ScrollViewController {

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
        
        headers.append(SeparatorCellView(separator: Separator(separatorStyle: .long), titleText: "Long"))
        headers.append(SeparatorCellView(separator: Separator(separatorStyle: .short), titleText: "Short"))
        
        headers.forEach() {
            $0.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview($0)
        }
        
        segmentControl.setTitles(["Default", "Disabled"])
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
