//
//  ActionBarViewControllerTwo.swift
//  ExampleiOS
//
//  Created on 07.02.2022.
//

import AdmiralUIKit
import AdmiralUIResources
import AdmiralTheme
import UIKit

final class ActionBarViewControllerSecondary: ScrollViewController {

    // MARK: - Private Properties

    private let viewModel = ActionBarViewModelSecondary()
    private var cells: [ActionCellView<ListCell<ImageCardListView, TitleLargeSubtitleListView, SubtitleWithImageListView>>] = []

    // MARK: - Initializers

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    override func apply(theme: AppTheme) {
        super.apply(theme: theme)
        cells.forEach({ $0.apply(theme: theme) })
    }

    // MARK: - Private Methods

    private func configureUI() {
        hideSegmentView(false)

        navigationItem.title = viewModel.title

        configureCells()

        cells.forEach() {
            $0.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview($0)
        }
        segmentControl.setTitles(viewModel.tabs)
        segmentControl.selectedSegmentIndex = 0
        segmentControl.addTarget(self, action: #selector(segmentedValueChanged), for: .valueChanged)
    }

    private func configureCells() {
        cells.append(configureTitleCell())
    }

    private func configureTitleCell() -> ActionCellView<ListCell<ImageCardListView, TitleLargeSubtitleListView, SubtitleWithImageListView>> {
        let titleListView = TitleLargeSubtitleListView()
        titleListView.title = "Card"
        titleListView.subtitle = "50 000.00 ₽"
        let cardListView = ImageCardListView()
        cardListView.cardImage = Asset.Card.visa.image

        let swipeView = SubtitleWithImageListView()
        swipeView.subtitle = "Swipe"
        swipeView.image = AdmiralUIResources.Asset.System.Outline.arrowLeftOutline.image

        let listCell = ListCell<ImageCardListView, TitleLargeSubtitleListView, SubtitleWithImageListView>(
            leadingView: cardListView,
            centerView: titleListView,
            tralingView: swipeView)
        let actionCellView = ActionCellView(cellView: listCell, style: .secondary)
        viewModel.actions.forEach { actionCellView.appendAction($0) }
        return actionCellView
    }

    @objc private func segmentedValueChanged(_ control: StandardSegmentedControl) {
        cells.forEach({
            $0.isEnabled = control.selectedSegmentIndex == 1 ? false : true
        })
    }

}
