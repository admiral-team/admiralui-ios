//
//  BadgesViewController.swift
//  Example iOS
//
//  Created on 16.10.2020.
//

import AdmiralUIKit
import AdmiralTheme
import UIKit

final class BadgesViewController: ScrollViewController {
    
    // MARK: - Private Properties
    
    private enum BadgeState: Int {
        case enabled
        case disabled
    }

    private var badgeViews = [BadgeCellView]()
    
    // MARK: - Initializers

    override func loadView() {
        segmentControl = StandardSegmentedControl(
            titles: ["Default",
                     "Disabled"])
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
        let additionalBadge = NumberBadge()
        additionalBadge.style = .additional
        let additionalBadgeView = BadgeCellView<Badge>(title: "Addittional", badgeView: additionalBadge)
        
        badgeViews.append(additionalBadgeView)
        
        let naturalBadge = NumberBadge()
        naturalBadge.style = .natural
        let naturalBadgeView = BadgeCellView<Badge>(title: "Natural", badgeView: naturalBadge)
        
        badgeViews.append(naturalBadgeView)
        
        let defaultBadge = NumberBadge()
        defaultBadge.style = .default
        let defaultBadgeView = BadgeCellView<Badge>(title: "Default", badgeView: defaultBadge)

        badgeViews.append(defaultBadgeView)

        let succesBadge = NumberBadge()
        succesBadge.style = .success
        let successBadgeView = BadgeCellView<Badge>(title: "Success", badgeView: succesBadge)

        badgeViews.append(successBadgeView)

        let errorBadge = NumberBadge()
        errorBadge.style = .error
        let errorBadgeView = BadgeCellView<Badge>(title: "Error", badgeView: errorBadge)

        badgeViews.append(errorBadgeView)

        let attentionBadge = NumberBadge()
        attentionBadge.style = .attention
        let attentionBadgeView = BadgeCellView<Badge>(title: "Attention", badgeView: attentionBadge)
        
        badgeViews.append(attentionBadgeView)
    }
    
    @objc private func segmentedValueChanged(_ control: StandardSegmentedControl) {
        guard let state = BadgeState(rawValue: control.selectedSegmentIndex) else { return }
        
        badgeViews.forEach({ $0.isEnabled = state == .enabled ? true : false })
    }
    
}
