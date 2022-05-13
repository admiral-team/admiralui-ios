//
//  ActionBarViewModel.swift
//  ExampleiOS
//
//  Created on 13.05.2022.
//

import AdmiralUIKit
import Foundation

final class ActionBarViewModel {

    // MARK: - Internal Properties

    var title: String {
        "ActionBar - Type default"
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
                imageStyle: .error,
                style: .default,
                handler: { print("Tap") }
            ),
            ActionItemBarAction(
                image: Asset.ActionBar.union.image,
                imageStyle: .accent,
                style: .default,
                handler: { print("Tap") }
            ),
            ActionItemBarAction(
                image: Asset.ActionBar.arrowDownOutline.image,
                imageStyle: .primary,
                style: .default,
                handler: { print("Tap") }
            ),
            ActionItemBarAction(
                image: Asset.ActionBar.arrowUpOutline.image,
                imageStyle: .primary,
                style: .default,
                handler: { print("Tap") }
            ),
            ActionItemBarAction(
                image: Asset.ActionBar.moreOutline.image,
                imageStyle: .accent,
                style: .default,
                handler: { print("Tap") }
            )
        ]
    }

}
