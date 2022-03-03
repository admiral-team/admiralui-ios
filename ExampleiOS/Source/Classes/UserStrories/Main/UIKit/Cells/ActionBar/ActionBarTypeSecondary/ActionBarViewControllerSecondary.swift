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

    var cells: [ActionCellView<ListCell<ImageCardListView, TitleLargeSubtitleListView, SubtitleWithImageListView>>] = []

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

        navigationItem.title = "ActionBar - Type secondary"

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

        let actionOne = createActionWithCustomColors(
            Asset.ActionBar.closeOutline.image,
            style: .secondary,
            backGroundColor: .red,
            imageTintColor: .white
        )
        actionCellView.appendAction(actionOne)

        let actionSecond = createAction(Asset.ActionBar.union.image, imageStyle: .success, style: .secondary)
        actionCellView.appendAction(actionSecond)

        let actionThrid = createAction(Asset.ActionBar.arrowDownOutline.image, imageStyle: .accent, style: .secondary)
        actionCellView.appendAction(actionThrid)

        return actionCellView
    }

    private func createAction(_ image: UIImage, imageStyle: ActionBarItemImageStyle, style: ActionBarItemStyle = .default) -> ActionItemBarAction {
        return ActionItemBarAction(
            image: image,
            imageStyle: imageStyle,
            style: style,
            text: "Text",
            handler: {}
        )
    }

    private func createActionWithCustomColors(_ image: UIImage, style: ActionBarItemStyle = .default, backGroundColor: UIColor, imageTintColor: UIColor) -> ActionItemBarAction {
        return ActionItemBarAction(
            image: image,
            imageTintColor: imageTintColor,
            backgroundColor: backGroundColor,
            style: style,
            text: "Text",
            handler: {}
        )
    }

    @objc private func segmentedValueChanged(_ control: StandardSegmentedControl) {
        cells.forEach({
            $0.isEnabled = control.selectedSegmentIndex == 1 ? false : true
        })
    }

}
