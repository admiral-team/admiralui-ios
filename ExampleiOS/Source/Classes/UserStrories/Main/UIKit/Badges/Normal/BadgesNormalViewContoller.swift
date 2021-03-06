//
//  BadgesNormalViewContoller.swift
//  ExampleiOS
//
//  Created on 05.04.2022.
//

import AdmiralUIKit
import AdmiralTheme
import UIKit

final class BadgesNormalViewContoller: ScrollViewController {

    // MARK: - Private Properties

    private enum BadgeState: Int {
        case enabled
        case disabled
    }

    private var badgeViews = [BadgeCellView]()
    private let viewModel = BadgesNormalViewModel()

    // MARK: - Initializers

    override func loadView() {
        segmentControl = StandardSegmentedControl(titles: viewModel.titles)
        super.loadView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        hideSegmentView(false)
        refreshTheme()
    }

    // MARK: - AnyAppThemable

    override func apply(theme: AppTheme) {
        super.apply(theme: theme)

        badgeViews.forEach({ $0.apply(theme: theme) })
    }

    // MARK: - Private Methods

    private func configureUI() {
        configureBadgeViews()

        badgeViews.forEach() {
            stackView.addArrangedSubview($0)
        }
        segmentControl.addTarget(self, action: #selector(segmentedValueChanged), for: .valueChanged)
    }

    private func configureBadgeViews() {
        viewModel.items.forEach { item in
            let additionalBadge = NumberBadge()
            additionalBadge.style = item.style
            let additionalBadgeView = BadgeCellView<Badge>(title: item.title, badgeView: additionalBadge, initialValue: 1)
            badgeViews.append(additionalBadgeView)
        }
    }

    @objc private func segmentedValueChanged(_ control: StandardSegmentedControl) {
        guard let state = BadgeState(rawValue: control.selectedSegmentIndex) else { return }

        badgeViews.forEach({ $0.isEnabled = state == .enabled ? true : false })
    }

}
