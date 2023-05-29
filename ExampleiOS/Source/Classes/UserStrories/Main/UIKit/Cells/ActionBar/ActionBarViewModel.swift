//
//  ActionBarViewModel.swift
//  ExampleiOS
//
//  Created by Борисов Кирилл Анатольевич on 23.05.2022.
//

import AdmiralUIKit
import AdmiralImages
import UIKit

final class ActionBarViewModel {

    struct ActionBarItem {
        let header: String
        let title: String
        let subTitle: String
        let cardImage: UIImage
        let swipeSubtitle: String
        let swipeImage: UIImage
        let type: ActionBarViewStyle
        let actions: [ActionItemBarAction]
        let accessibilityIdentifier: String?
    }

    // MARK: - Internal Properties

    var items: [ActionBarItem] = []

    // MARK: - Computed Properties

    var defaultActions: [ActionItemBarAction] {
        [
            ActionItemBarAction(
                image: Asset.ActionBar.closeOutline.image,
                imageStyle: .error,
                style: .default,
                accesibilityId: "defaultActionItemBarActionOne",
                handler: {}
            ),
            ActionItemBarAction(
                image: Asset.ActionBar.union.image,
                imageStyle: .accent,
                style: .default,
                accesibilityId: "defaultActionItemBarActionTwo",
                handler: {}
            ),
            ActionItemBarAction(
                image: Asset.ActionBar.arrowDownOutline.image,
                imageStyle: .primary,
                style: .default,
                accesibilityId: "defaultActionItemBarActionThree",
                handler: {}
            ),
            ActionItemBarAction(
                image: Asset.ActionBar.arrowUpOutline.image,
                imageStyle: .primary,
                style: .default,
                accesibilityId: "defaultActionItemBarActionFour",
                handler: {}
            ),
            ActionItemBarAction(
                image: Asset.ActionBar.moreOutline.image,
                imageStyle: .accent,
                style: .default,
                accesibilityId: "defaultActionItemBarActionFive",
                handler: {}
            )
        ]
    }

    var secondaryActions: [ActionItemBarAction] {
        [
            ActionItemBarAction(
                image: Asset.ActionBar.shape.image,
                imageStyle: .attention,
                style: .secondary,
                text: "Text",
                accesibilityId: "secondaryActionItemBarActionOne",
                handler: {}
            ),
            ActionItemBarAction(
                image: Asset.ActionBar.union.image,
                imageStyle: .success,
                style: .secondary,
                text: "Text",
                accesibilityId: "secondaryActionItemBarActionTwo",
                handler: {}
            ),
            ActionItemBarAction(
                image: Asset.ActionBar.mail.image,
                imageStyle: .accent,
                style: .secondary,
                text: "Text",
                accesibilityId: "secondaryActionItemBarActionThree",
                handler: {}
            )
        ]
    }

    // MARK: - Initializer

    init() {
        items = [
            ActionBarItem(
                header: "Default",
                title: "Card",
                subTitle: "50 000.00 ₽",
                cardImage: Asset.Card.visa.image,
                swipeSubtitle: "Swipe",
                swipeImage: AdmiralImages.Asset.System.Outline.arrowLeftOutline.image,
                type: .default,
                actions: defaultActions,
                accessibilityIdentifier: "defaultAction"
            ),
            ActionBarItem(
                header: "Secondary",
                title: "Card",
                subTitle: "50 000.00 ₽",
                cardImage: Asset.Card.visa.image,
                swipeSubtitle: "Swipe",
                swipeImage: AdmiralImages.Asset.System.Outline.arrowLeftOutline.image,
                type: .secondary,
                actions: secondaryActions,
                accessibilityIdentifier: "secondaryAction"
            )
        ]
    }

}
