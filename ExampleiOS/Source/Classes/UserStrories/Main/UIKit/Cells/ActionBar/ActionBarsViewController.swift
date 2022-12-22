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

final class ActionBarsViewController: ScrollViewController {

    private let viewModel = ActionBarViewModel()
    private var cells: [ActionBarCellView] = []

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

        navigationItem.title = "Actionbar"

        configureCells()

        cells.forEach() {
            $0.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview($0)
        }
        segmentControl.setTitles(["Default", "Disabled"])
        segmentControl.selectedSegmentIndex = 0
        segmentControl.addTarget(self, action: #selector(segmentedValueChanged), for: .valueChanged)
    }

    private func configureCells() {
        configureTitleCell()
    }

    private func configureTitleCell() {
        viewModel.items.forEach { item in
            let actionCellView = ActionCellView(cellView: createTitleListView(item: item), style: item.type)
            actionCellView.accessibilityIdentifier = item.accessibilityIdentifier
            item.actions.forEach { action in actionCellView.appendAction(action) }
            cells.append(ActionBarCellView(actionBars: [actionCellView], titleText: item.header))
        }
    }

    private func createTitleListView(item: ActionBarViewModel.ActionBarItem) -> ListCell<LeadingCardListView, TitleLargeSubtitleListView, SubtitleWithImageListView> {
        let titleListView = TitleLargeSubtitleListView()
        titleListView.title = item.title
        titleListView.subtitle = item.subTitle
        let cardListView = LeadingCardListView()
        cardListView.cardImage = item.cardImage

        let swipeView = SubtitleWithImageListView()
        swipeView.subtitle = item.swipeSubtitle
        swipeView.image = item.swipeImage

        return ListCell<LeadingCardListView, TitleLargeSubtitleListView, SubtitleWithImageListView>(
            leadingView: cardListView,
            centerView: titleListView,
            tralingView: swipeView
        )
    }

    @objc private func segmentedValueChanged(_ control: StandardSegmentedControl) {
        cells.forEach({
            $0.isEnabled = control.selectedSegmentIndex == 1 ? false : true
        })
    }

}
