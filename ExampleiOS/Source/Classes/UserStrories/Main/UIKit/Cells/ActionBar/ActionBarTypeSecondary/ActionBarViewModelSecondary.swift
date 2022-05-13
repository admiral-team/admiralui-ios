//
//  ActionBarViewModelSecondary.swift
//  ExampleiOS
//
//  Created on 13.05.2022.
//

import AdmiralUIKit
import Foundation

final class ActionBarViewModelSecondary {

    // MARK: - Internal Properties

    var title: String {
        "ActionBar - Type secondary"
    }

    var tabs: [String] {
        ["Default", "Disabled"]
    }

    var actions: [ActionItemBarAction]

    // MARK: - Initializer

    init() {
        actions = [
            ActionItemBarAction(
                image: Asset.ActionBar.closeOutline.image,
                imageTintColor: .white,
                backgroundColor: .red,
                style: .secondary,
                text: "Text",
                handler: {}
            ),
            ActionItemBarAction(
                image: Asset.ActionBar.union.image,
                imageStyle: .success,
                style: .secondary,
                text: "Text",
                handler: { print("Tap") }
            ),
            ActionItemBarAction(
                image: Asset.ActionBar.arrowDownOutline.image,
                imageStyle: .accent,
                style: .secondary,
                text: "Text",
                handler: { print("Tap") }
            )
        ]
    }

}
