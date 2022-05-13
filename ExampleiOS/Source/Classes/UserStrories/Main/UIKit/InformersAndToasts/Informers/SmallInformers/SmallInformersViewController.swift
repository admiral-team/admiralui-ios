//
//  SmallInformersViewController.swift
//  ExampleiOS
//
//  Created on 23.11.2020.
//

import AdmiralUIKit
import AdmiralTheme
import UIKit

final class SmallInformersViewController: ScrollViewController {

    private enum InformerState: Int {
        case enabled
        case disabled
    }

    // MARK: - Private Properties

    private var views = [SmallInformerView]()
    private let viewModel = SmallInformersViewModel()
    
    // MARK: - Initializers
    
    override func loadView() {
        segmentControl = StandardSegmentedControl(
            titles: ["Default",
                     "Disabled"])
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideSegmentView(false)
        configureUI()
        refreshTheme()
    }
    
    // MARK: - AppThemable
    
    override func apply(theme: AppTheme) {
        super.apply(theme: theme)
        views.forEach({
            $0.apply(theme: theme)
        })
    }
    
    // MARK: - Private Methods
    
    private func configureUI() {
        configureBadgeViews()
        views.forEach() {
            stackView.addArrangedSubview($0)
        }
        segmentControl.addTarget(self, action: #selector(segmentedValueChanged), for: .valueChanged)
    }
    
    private func configureBadgeViews() {
        viewModel.items.forEach {
            let informer = SmallInformerView()
            informer.configureWith(model: $0)
            if let direction = $0.direction {
                informer.setInformerArrowDirecdtion(direction: direction)
            }
            views.append(informer)
        }
    }
    
    @objc private func segmentedValueChanged(_ control: StandardSegmentedControl) {
        guard let state = InformerState(rawValue: control.selectedSegmentIndex) else { return }
        
        views.forEach({ $0.setInformerState(isEnabled: state == .enabled ? true : false) })
    }
    
}
