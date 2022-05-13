//
//  BigInformersController.swift
//  ExampleiOS
//
//  Created on 23.11.2020.
//

import AdmiralUIKit
import AdmiralTheme
import UIKit

final class BigInformersController: ScrollViewController {
    
    // MARK: - Private Properties

    private let viewModel = BigInformersViewModel()
    private var views = [UIView]()
    
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
    
    // MARK: - AnyAppThemable
    
    override func apply(theme: AppTheme) {
        super.apply(theme: theme)
        views.forEach({
            if let view = $0 as? BigInformerView {
                view.apply(theme: theme)
            } else if let view = $0 as? MessageInformerView {
                view.apply(theme: theme)
            }
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
            if let item = $0 as? BigInformerViewViewModel {
                let defaultInformer = BigInformerView()
                defaultInformer.configureWith(model: item)
                views.append(defaultInformer)
            } else if let item = $0 as? MessageInformerViewViewModel {
                let messageInformer = MessageInformerView()
                messageInformer.configureWith(model: item)
                views.append(messageInformer)
            }
        }
    }
    
    @objc private func segmentedValueChanged(_ control: StandardSegmentedControl) {
        guard let state = control.selectedSegmentIndex == 1 ? false : true else { return }
        
        views.forEach({ if let informer = $0 as? Informer {
            informer.isEnabled = state
        }})
    }
    
}
