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

    // MARK: - Private Properties

    private let viewModel = ButtonsViewModel()

    private let bigContainerView: BigButtonContainerView = {
        let primaryTwoTitle = TwoTitleButton()
        primaryTwoTitle.leftButtonTitle = "08.06.20 - 14.08.20"
        primaryTwoTitle.rightButtonTitle = "Выбрать"
        return BigButtonContainerView(button: primaryTwoTitle)
    }()

    private lazy var infoAgrementView: InfoAgreementView = {
        let infoAgreementView = InfoAgreementView()
        infoAgreementView.actionText = "Действие"
        infoAgreementView.alternativeText = "Альтернативное действие"
        infoAgreementView.cheboxText = "Я согласен с условиями договора и подтверждаю свое согласие на обработку персональных данных"
        infoAgreementView.checkboxButtonText = "Открыть список документов"
        infoAgreementView.delegate = self
        return infoAgreementView
    }()

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
        configureButtons()
        segmentControl.setTitles(viewModel.tabs)
        segmentControl.selectedSegmentIndex = 0
        segmentControl.addTarget(self, action: #selector(segmentedValueChanged), for: .valueChanged)
    }

    private func configureButtons() {
        viewModel.items.forEach {
            var buttonViews: [ButtonsView.ButtonViews] = []
            switch $0.type {
            case .secondary:
                $0.items.forEach { button in
                    let primaryButton = SecondaryButton()
                    primaryButton.setTitle(button.title, for: .normal)
                    addButtonsToContainer(primaryButton, &buttonViews, button.size)
                }
            case .ghost:
                buttonViews.append(bigContainerView)
                $0.items.forEach { button in
                    let primaryButton = GhostButton()
                    primaryButton.setTitle(button.title, for: .normal)
                    addButtonsToContainer(primaryButton, &buttonViews, button.size)
                }
            case .primary:
                buttonViews.append(bigContainerView)
                $0.items.forEach { button in
                    let primaryButton = PrimaryButton()
                    primaryButton.setTitle(button.title, for: .normal)
                    addButtonsToContainer(primaryButton, &buttonViews, button.size)
                }
            case .rules:
                buttonViews.append(infoAgrementView)
            }
            stackView.addArrangedSubview(ButtonsView(buttonViews: buttonViews, title: $0.title))
        }
    }

    private func addButtonsToContainer(
        _ button: Button,
        _ buttonViews: inout [ButtonsView.ButtonViews],
        _ size: ButtonsViewModel.ButtonItem.Size
    ) {
        switch size {
        case .small:
            let smallContainer = SmallButtonContainerView(button: button)
            buttonViews.append(smallContainer)
        case .big:
            let bigContainer = BigButtonContainerView(button: button)
            buttonViews.append(bigContainer)
        case .medium:
            let mediumContainer = MediumButtonContainerView(button: button)
            buttonViews.append(mediumContainer)
        }
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
