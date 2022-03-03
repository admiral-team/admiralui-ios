//
//  ButtonsViewController.swift
//  Example iOS
//
//  Created on 14.10.2020.
//

import AdmiralUIKit
import AdmiralTheme
import UIKit

final class ButtonsViewController: ScrollViewController {
    
    // MARK: - Initializers
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideSegmentView(false)
        configureUI()
        apply(theme: Appearance.shared.theme)
    }
    
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
        configurePrimaryButtonSections()
        configurSecondaryButtonSections()
        configurGhostButtonSections()
        configureRulesView()
        
        segmentControl.setTitles(["Default", "Disabled"])
        segmentControl.selectedSegmentIndex = 0
        segmentControl.addTarget(self, action: #selector(segmentedValueChanged), for: .valueChanged)
    }
    
    private func configurePrimaryButtonSections() {
        let primaryTwoTitle = TwoTitleButton()
        primaryTwoTitle.leftButtonTitle = "08.06.20 - 14.08.20"
        primaryTwoTitle.rightButtonTitle = "Выбрать"
        let twoTitleContainer = BigButtonContainerView(button: primaryTwoTitle)

        let primaryButtonBig = PrimaryButton()
        primaryButtonBig.setTitle("Big Button", for: .normal)
        let bigContainer = BigButtonContainerView(button: primaryButtonBig)
        
        let primaryButtonMedium = PrimaryButton()
        primaryButtonMedium.setTitle("Medium Button", for: .normal)
        let mediumContainer = MediumButtonContainerView(button: primaryButtonMedium)
        
        let primaryButtonSmall = PrimaryButton()
        primaryButtonSmall.setTitle("Small Button", for: .normal)
        let smallContainer = SmallButtonContainerView(button: primaryButtonSmall)
        
        let buttonsContainer = ButtonsView(
            buttonViews:
                [twoTitleContainer,
                 bigContainer,
                 mediumContainer,
                 smallContainer],
            title: "Primary")
        stackView.addArrangedSubview(buttonsContainer)
    }
    
    private func configurSecondaryButtonSections() {
        let secondaryButtonBig = SecondaryButton()
        secondaryButtonBig.setTitle("Big Button", for: .normal)
        let bigContainer = BigButtonContainerView(button: secondaryButtonBig)
        
        let secondaryButtonMedium = SecondaryButton()
        secondaryButtonMedium.setTitle("Medium Button", for: .normal)
        let mediumContainer = MediumButtonContainerView(button: secondaryButtonMedium)
        
        let secondaryButtonSmall = SecondaryButton()
        secondaryButtonSmall.setTitle("Small Button", for: .normal)
        let smallContainer = SmallButtonContainerView(button: secondaryButtonSmall)
        
        let buttonsContainer = ButtonsView(
            buttonViews:
                [bigContainer,
                 mediumContainer,
                 smallContainer],
            title: "Secondary")
        
        stackView.addArrangedSubview(buttonsContainer)
    }
    
    private func configurGhostButtonSections() {
        let ghostTwoTitle = TwoTitleGhostButton()
        ghostTwoTitle.leftButtonTitle = "08.06.20 - 14.08.20"
        ghostTwoTitle.rightButtonTitle = "Выбрать"
        let ghostTwoTitleContainer = BigButtonContainerView(button: ghostTwoTitle)
        
        let ghostButtonBig = GhostButton()
        ghostButtonBig.setTitle("Big Button", for: .normal)
        let ghostBigContainer = BigButtonContainerView(button: ghostButtonBig)
        
        let ghostButtonSmall = GhostButton()
        ghostButtonSmall.setTitle("Small Button", for: .normal)
        let ghostSmallContainer = SmallButtonContainerView(button: ghostButtonSmall)

        let buttonsContainer = ButtonsView(
            buttonViews:
                [ghostTwoTitleContainer,
                 ghostBigContainer,
                 ghostSmallContainer],
            title: "Ghost")
        stackView.addArrangedSubview(buttonsContainer)
    }
    
    private func configureRulesView() {
        let infoAgreementView = InfoAgreementView()
        infoAgreementView.actionText = "Действие"
        infoAgreementView.alternativeText = "Альтернативное действие"
        infoAgreementView.cheboxText = "Я согласен с условиями договора и подтверждаю свое согласие на обработку персональных данных"
        infoAgreementView.checkboxButtonText = "Открыть список документов"
        infoAgreementView.delegate = self
        
        let buttonsContainer = ButtonsView(
            buttonViews:
                [infoAgreementView],
            title: "Rules")
        stackView.addArrangedSubview(buttonsContainer)
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

// MARK: - InfoAgreementViewDelegate

extension ButtonsViewController: InfoAgreementViewDelegate {
    
    func checkBoxShouldSelected(_ checkBox: CheckBox) -> Bool {
        return !checkBox.isSelected
    }
    
}
