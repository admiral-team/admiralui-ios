//
//  SecondaryButtonsViewController.swift
//  ExampleiOS
//
//  Created on 14.06.2022.
//

import AdmiralUIResources
import AdmiralUIKit
import AdmiralTheme
import UIKit

final class SecondaryButtonsViewController: ScrollViewController {
    
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
    private let heartImage = AdmiralUIResources.Asset.Category.Outline.heartOutline.image
    private let maintenanceImage = AdmiralUIResources.Asset.Category.Solid.maintenanceSolid.image
    
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
        configureBigButton()
        configureMediumButton()
        configureSmallButton()

        stackView.addArrangedSubview(buttonsContainer)
        
        segmentControl.setTitles(["Default", "Disabled"])
        segmentControl.selectedSegmentIndex = 0
        segmentControl.addTarget(self, action: #selector(segmentedValueChanged), for: .valueChanged)
    }
    
    // MARK: Big Button
    
    private func configureBigButton() {
        let primaryButtonBig = createPrimaryButton(name: "Big Button", image: heartImage, direction: .left)
        let bigContainer = BigButtonContainerView(button: primaryButtonBig)
        buttonsContainer.buttonViews.append(bigContainer)
        
        let secondPrimaryButtonBig = createPrimaryButton(name: "Big Button", image: maintenanceImage, direction: .right)
        let secondBigContainer = BigButtonContainerView(button: secondPrimaryButtonBig)
        buttonsContainer.buttonViews.append(secondBigContainer)
        
        let thirdPrimaryButtonBig = createPrimaryButton(name: "Big Button", image: nil, direction: nil)
        let thirdBigContainer = BigButtonContainerView(button: thirdPrimaryButtonBig)
        buttonsContainer.buttonViews.append(thirdBigContainer)
    }
    
    // MARK: Medium Button
    
    private func configureMediumButton() {
        let primaryButtonMedium = createPrimaryButton(name: "Medium Button", image: heartImage, direction: .left)
        let mediumContainer = MediumButtonContainerView(button: primaryButtonMedium)
        buttonsContainer.buttonViews.append(mediumContainer)

        let secondPrimaryButtonMedium = createPrimaryButton(name: "Medium Button", image: maintenanceImage, direction: .right)
        let secondMediumContainer = MediumButtonContainerView(button: secondPrimaryButtonMedium)
        buttonsContainer.buttonViews.append(secondMediumContainer)

        let thirdPrimaryButtonMedium = createPrimaryButton(name: "Medium Button", image: nil, direction: nil)
        let thirdMediumContainer = MediumButtonContainerView(button: thirdPrimaryButtonMedium)
        buttonsContainer.buttonViews.append(thirdMediumContainer)
    }
    
    // MARK: Small Button
    
    func configureSmallButton() {
        let primaryButtonSmall = createPrimaryButton(name: "Small Button", image: heartImage, direction: .left)
        let smallContainer = SmallButtonContainerView(button: primaryButtonSmall)
        buttonsContainer.buttonViews.append(smallContainer)
        
        let secondPrimaryButtonSmall = createPrimaryButton(name: "Small Button", image: maintenanceImage, direction: .right)
        let secondSmallContainer = SmallButtonContainerView(button: secondPrimaryButtonSmall)
        buttonsContainer.buttonViews.append(secondSmallContainer)
        
        let thirdPrimaryButtonSmall = createPrimaryButton(name: "Small Button", image: nil, direction: nil)
        let thirdSmallContainer = SmallButtonContainerView(button: thirdPrimaryButtonSmall)
        buttonsContainer.buttonViews.append(thirdSmallContainer)
    }
    
    // MARK: Create Button
    
    private func createPrimaryButton(name: String, image: UIImage?, direction: ImageDirection?) -> UIButton {
        let button = SecondaryButton()
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
                button.imageEdgeInsets = UIEdgeInsets(top: 0, left: LayoutGrid.doubleModule, bottom: 0, right: 0)
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
