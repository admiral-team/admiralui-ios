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
    
    // MARK: - Private Properties
    
    private enum InformerState: Int {
        case enabled
        case disabled
    }
    
    private struct Constants {
        static let title: String = "Text Informer"
        // swiftlint:disable all
        static let description: String = "At breakpoint boundaries, mini units divide the screen into a fixed master grid, and multiples of mini units map to fluid grid column widths and row heights.divide the screen into a fixed master grid, and multiples of mini units map to fluid grid column widths and row heights."
        // swiftlint:enable all
    }

    private var views = [SmallInformerView]()
    
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
        let defaultInformer = SmallInformerView()
        defaultInformer.configureWith(model: .init(headLine: "Default", title: Constants.description, style: .default))
        views.append(defaultInformer)
        
        let succesInformer = SmallInformerView()
        succesInformer.configureWith(model: .init(headLine: "Success", title: Constants.title, style: .success))
        views.append(succesInformer)
        
        let attentionInformer = SmallInformerView()
        attentionInformer.configureWith(model: .init(headLine: "Attention", title: Constants.title, style: .attention))
        attentionInformer.setInformerArrowDirecdtion(direction: .down)
        views.append(attentionInformer)
        
        let errorInformer = SmallInformerView()
        errorInformer.configureWith(model: .init(headLine: "Error", title: Constants.title, style: .error))
        views.append(errorInformer)
    }
    
    @objc private func segmentedValueChanged(_ control: StandardSegmentedControl) {
        guard let state = InformerState(rawValue: control.selectedSegmentIndex) else { return }
        
        views.forEach({ $0.setInformerState(isEnabled: state == .enabled ? true : false) })
    }
    
}
