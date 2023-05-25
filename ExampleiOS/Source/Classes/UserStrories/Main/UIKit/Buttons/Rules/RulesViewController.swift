//
//  RulesViewController.swift
//  ExampleiOS
//
//  Created on 15.06.2022.
//

import AdmiralUIKit
import AdmiralTheme
import UIKit

final class RulesViewController: ScrollViewController {
    
    // MARK: - Initializers
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideSegmentView(false)
        configureUI()
        apply(theme: Appearance.shared.theme)
    }
    
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
        configureRulesView()
        stackView.addArrangedSubview(buttonsContainer)
        
        segmentControl.setItems([
        StandardSegmentedItem(title: "Default", accesibilityId: "SegmentControlDefault"),
        StandardSegmentedItem(title: "Disabled", accesibilityId: "SegmentControlDisabled")])
        segmentControl.selectedSegmentIndex = 0
        segmentControl.addTarget(self, action: #selector(segmentedValueChanged), for: .valueChanged)
    }
    
    private func configureRulesView() {
        let infoAgreementView = InfoAgreementView()
        infoAgreementView.checkboxText = "Я согласен с условиями договора и подтверждаю свое согласие на обработку персональных данных"
        infoAgreementView.checkboxButtonText = "Открыть список документов"
        infoAgreementView.delegate = self
        infoAgreementView.actionButtonAccesibilityId = "InfoAgreementViewActionButton"
        infoAgreementView.alternativeButtonAccesibilityId = "InfoAgreementViewAlternativeButton"
        infoAgreementView.checkBoxTextAccesibilityId = "InfoAgreementViewCheckBoxText"

        buttonsContainer.buttonViews.append(infoAgreementView)
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

extension RulesViewController: InfoAgreementViewDelegate {
    
    func checkBoxShouldSelected(_ checkBox: CheckBox) -> Bool {
        !checkBox.isSelected
    }
    
}
