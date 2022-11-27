//
//  OtherButtonViewController.swift
//  ExampleiOS
//
//  Created on 05.07.2022.
//

import AdmiralUIResources
import AdmiralUIKit
import AdmiralTheme
import UIKit

final class OtherButtonsViewController: ScrollViewController {
    
    // MARK: - Image Direction
    
    enum ImageDirection {
        case left
        case right
    }
    
    // MARK: - Initializers
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideSegmentView(false)
        configureUI()
        apply(theme: Appearance.shared.theme)
    }
    
    // MARK: - Internal Properties
    
    private let buttonsContainer = ButtonsView(buttonViews: [])
    
    // MARK: - Internal Methods
    
    override func apply(theme: AppTheme) {
        super.apply(theme: theme)
        view.backgroundColor = theme.colors.backgroundBasic.uiColor
        stackView.arrangedSubviews.forEach({
            ($0 as? AppThemeCompatible)?.apply(theme: theme)
        })
    }
    
    // MARK: - Private Methods
    
    private func configureUI() {
        configurePlatformButton()

        stackView.addArrangedSubview(buttonsContainer)
        
        segmentControl.setItems([
        StandardSegmentedItem(title: "Default", accesibilityId: "SegmentControlDefault"),
        StandardSegmentedItem(title: "Disabled", accesibilityId: "SegmentControlDisabled")])
        segmentControl.selectedSegmentIndex = 0
        segmentControl.addTarget(self, action: #selector(segmentedValueChanged), for: .valueChanged)
    }
    
    // MARK: Platform Button
    
    private func configurePlatformButton() {
        let primaryButtonBig = createPrimaryButton(name: "Добавить в Apple Wallet", image: Asset.Card.appleWallet.image, direction: .left)
        primaryButtonBig.accessibilityIdentifier = "OtherButton"
        let bigContainer = BigButtonContainerView(button: primaryButtonBig)
        buttonsContainer.buttonViews.append(bigContainer)
    }
    
    // MARK: Create Button
    
    private func createPrimaryButton(name: String, image: UIImage?, direction: ImageDirection?) -> UIButton {
        let button = PlatformButton()
        button.setTitle(name, for: .normal)
        if let image = image, let direction = direction {
            button.setImage(image, for: .normal)
            button.setImage(image, for: .highlighted)
            switch direction {
            case .left:
                button.semanticContentAttribute = .forceLeftToRight
                button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: LayoutGrid.doubleModule)
            case .right:
                button.semanticContentAttribute = .forceRightToLeft
                button.imageEdgeInsets = UIEdgeInsets(top: 0, left: LayoutGrid.module, bottom: 0, right: 0)
            }
        }

        return button
    }
    
    @objc private func segmentedValueChanged(_ control: StandardSegmentedControl) {
        stackView.arrangedSubviews.forEach({
            let isEnabled = control.selectedSegmentIndex == 1 ? false : true
            ($0 as? ButtonsView)?.buttonViews.forEach({
                ($0 as? SmallButtonContainerView)?.isEnabled = isEnabled
                ($0 as? MediumButtonContainerView)?.isEnabled = isEnabled
                ($0 as? BigButtonContainerView)?.isEnabled = isEnabled
                ($0 as? InfoAgreementView)?.isEnabled = isEnabled
            })
        })
    }
    
}
