//
//  MapButtonsListViewController.swift
//  ExampleiOS
//
//  Created on 18.02.2022.
//

import AdmiralUIKit
import AdmiralCore
import AdmiralTheme
import AdmiralUIResources
import UIKit

final class MapButtonsListViewController: ScrollViewController {

    // MARK: - Private Properties

    private enum Constants {
        static let additionalViewSize = CGSize(width: LayoutGrid.halfModule * 6, height: LayoutGrid.halfModule * 6)
    }

    // MARK: - Private Properties

    private var views = [MapButtonCellView]()
    private let viewModel = MapButtonsListViewModel()

    // MARK: - Initializers

    override func loadView() {
        segmentControl = StandardSegmentedControl(titles: viewModel.segmentContolTitles)
        super.loadView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        hideSegmentView(false)
        configureUI()
    }

    // MARK: - AnyAppThemable

    override func apply(theme: AppTheme) {
        super.apply(theme: theme)

        views.forEach({ $0.apply(theme: theme) })
        view.backgroundColor = theme.colors.backgroundAdditionalOne.uiColor
        scrollView.backgroundColor = theme.colors.backgroundAdditionalOne.uiColor
        stackView.backgroundColor = theme.colors.backgroundAdditionalOne.uiColor
    }

    // MARK: - Private Methods

    private func configureUI() {
        autoManage()
        viewModel.buttons.forEach { buildButtonsList($0.buttons, $0.title) }
        views.forEach() { stackView.addArrangedSubview($0) }
        segmentControl.addTarget(self, action: #selector(segmentedValueChanged), for: .valueChanged)
    }

    private func buildButtonsList(_ buttons: [MapButtonsListViewModel.MapButtonItem], _ title: String) {
        var buttonsContainer: [UIButton] = []

        buttons.forEach {
            switch $0 {
            case .map(let type):
                let mapButtonMinus = MapButton()
                mapButtonMinus.type = type
                buttonsContainer.append(mapButtonMinus)
            case .pin(let image, let selection):
                let pinButton = PinButton()
                pinButton.isSelected = selection
                pinButton.image = image
                pinButton.addTarget(self, action: #selector(didTapSendButton), for: .touchUpInside)
                buttonsContainer.append(pinButton)
            case .severalPin(let size, let title):
                let sevaralPinSmall = SeveralPinButton()
                sevaralPinSmall.setTitle(title, for: .normal)
                sevaralPinSmall.style = size
                buttonsContainer.append(sevaralPinSmall)
            }
        }
        addButtons(buttons: buttonsContainer, titleText: title)
    }

    private func addButtons(buttons: [UIButton], titleText: String) {
        let cell = MapButtonCellView(buttons: buttons, titleText: titleText)
        views.append(cell)
    }

    @objc private func segmentedValueChanged(_ control: StandardSegmentedControl) {
        views.forEach({
            $0.isEnabled = control.selectedSegmentIndex == 1 ? false : true
        })
    }

    @objc private func didTapSendButton(_ sender: UIButton) {
        sender.isSelected.toggle()
    }

}
