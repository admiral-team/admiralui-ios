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
    
    private enum InformerState: Int {
        case enabled
        case disabled
    }
    
    private struct Constants {
        static let title: String = "Headline"
        // swiftlint:disable all
        static let description: String = "At breakpoint boundaries, mini units divide the screen into a fixed master grid, and multiples of mini units map to fluid grid column widths and row heights."
        // swiftlint:enable all
        static let linkText: String = "Link text"
    }
    
    private var views = [UIView]()
    
    // MARK: - Initializers
    
    override func loadView() {
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
        configureSegmentControl()
        configureBadgeViews()
        
        views.forEach() {
            stackView.addArrangedSubview($0)
        }
        stackView.distribution = .fillEqually
        segmentControl.addTarget(self, action: #selector(segmentedValueChanged), for: .valueChanged)
    }
    
    private func configureSegmentControl() {
            segmentControl.setItems([
                StandardSegmentedItem(title: "Default", accesibilityId: "SegmentControlDefault"),
                StandardSegmentedItem(title: "Disabled", accesibilityId: "SegmentControlDisabled")]
            )
        }
    
    private func configureBadgeViews() {
        let defaultInformer = BigInformerView()
        defaultInformer.configureWith(
            model: .init(
                headLine: "Default",
                title: Constants.title,
                description: Constants.description,
                linkLabel: Constants.linkText,
                style: .default))
        views.append(defaultInformer)
        
        let succesInformer = BigInformerView()
        succesInformer.configureWith(
            model: .init(
                headLine: "Success",
                title: Constants.title,
                description: Constants.description,
                linkLabel: Constants.linkText,
                style: .success))
        
        views.append(succesInformer)
        
        let attentionInformer = BigInformerView()
        attentionInformer.configureWith(
            model: .init(
                headLine: "Attention",
                title: Constants.title,
                description: Constants.description,
                linkLabel: Constants.linkText,
                style: .attention))
        
        views.append(attentionInformer)
        
        let errorInformer = BigInformerView()
        errorInformer.configureWith(
            model: .init(
                headLine: "Error",
                title: Constants.title,
                description: Constants.description,
                linkLabel: Constants.linkText,
                style: .error))
        
        views.append(errorInformer)
    }
    
    @objc private func segmentedValueChanged(_ control: StandardSegmentedControl) {
        guard let state = control.selectedSegmentIndex == 1 ? false : true else { return }
        
        views.forEach({ if let informer = $0 as? Informer {
            informer.isEnabled = state
        }})
    }
    
}
