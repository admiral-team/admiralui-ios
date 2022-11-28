//
//  LinksViewController.swift
//  ExampleiOS
//
//  Created on 24.02.2022.
//

import UIKit
import AdmiralUIKit
import AdmiralTheme

final class LinksHeaderViewController: ScrollViewController {
    
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
        
        headers.append(LinkViewHeader(title: "Подробнее на сайте банка"))
        
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
            if  let link = $0 as? LinkViewHeader {
                link.isEnabled = control.selectedSegmentIndex == 1 ? false : true
            }
        })
    }
    
}
