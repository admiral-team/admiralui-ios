//
//  StaticNotificationsViewController.swift
//  ExampleiOS
//
//  Created on 23.12.2021.
//

import AdmiralUIKit
import AdmiralTheme
import UIKit

final class StaticNotificationsViewController: ScrollViewController {

    // MARK: - Private Properties

    private let viewModel = StaticNotificationsViewModel()
    private var views = [StaticNotificationView]()
    
    // MARK: - Initializers
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideSegmentView(true)
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
    }
    
    private func configureBadgeViews() {
        viewModel.items.forEach {
            let view = StaticNotificationView()
            view.configureWith(model: $0)
            views.append(view)
        }
    }
    
}
