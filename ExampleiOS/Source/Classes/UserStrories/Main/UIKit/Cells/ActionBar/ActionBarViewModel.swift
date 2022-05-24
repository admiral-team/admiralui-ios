//
//  ActionBarViewModel.swift
//  ExampleiOS
//
//  Created by Борисов Кирилл Анатольевич on 23.05.2022.
//

import AdmiralUIKit
import AdmiralUIResources
import Foundation
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
    }

    // MARK: - Internal Properties

    let items: [ActionBarItem]

    // MARK: - Initializer

    init() {
        items = [
            ActionBarItem(
                header: "Default",
                title: "Card",
                subTitle: "50 000.00 ₽",
                cardImage: Asset.Card.visa.image,
                swipeSubtitle: "Swipe",
                swipeImage: AdmiralUIResources.Asset.System.Outline.arrowLeftOutline.image,
                type: .default,
                actions: [
                    ActionItemBarAction(
                        image: Asset.ActionBar.closeOutline.image,
                        imageStyle: .error,
                        style: .default,
                        handler: {}
                    ),
                    ActionItemBarAction(
                        image: Asset.ActionBar.union.image,
                        imageStyle: .accent,
                        style: .default,
                        handler: {}
                    ),
                    ActionItemBarAction(
                        image: Asset.ActionBar.arrowDownOutline.image,
                        imageStyle: .primary,
                        style: .default,
                        handler: {}
                    ),
                    ActionItemBarAction(
                        image: Asset.ActionBar.arrowUpOutline.image,
                        imageStyle: .primary,
                        style: .default,
                        handler: {}
                    ),
                    ActionItemBarAction(
                        image: Asset.ActionBar.moreOutline.image,
                        imageStyle: .accent,
                        style: .default,
                        handler: {}
                    )
                ]
            ),
            ActionBarItem(
                header: "Secondary",
                title: "Card",
                subTitle: "50 000.00 ₽",
                cardImage: Asset.Card.visa.image,
                swipeSubtitle: "Swipe",
                swipeImage: AdmiralUIResources.Asset.System.Outline.arrowLeftOutline.image,
                type: .secondary,
                actions: [
                    ActionItemBarAction(
                        image: Asset.ActionBar.shape.image,
                        imageStyle: .attention,
                        style: .secondary,
                        text: "Text",
                        handler: {}
                    ),
                    ActionItemBarAction(
                        image: Asset.ActionBar.union.image,
                        imageStyle: .success,
                        style: .secondary,
                        text: "Text",
                        handler: {}
                    ),
                    ActionItemBarAction(
                        image: Asset.ActionBar.mail.image,
                        imageStyle: .accent,
                        style: .secondary,
                        text: "Text",
                        handler: {}
                    )
                ]
            )
        ]
    }

}
