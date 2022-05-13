//
//  ActionBarSwiftUISecondaryViewModel.swift
//  ExampleiOS
//
//  Created on 03.05.2022.
//

import AdmiralSwiftUI
import Combine
import SwiftUI

@available(iOS 14.0.0, *)
final class ActionBarSwiftUISecondaryViewModel: ObservableObject {

    enum ActionBarSwiftUIItem: String, CaseIterable {
        case `default`
        case secondary

        var title: String {
            switch self {
            case .default:
                return "ActionBar - Type default"
            case .secondary:
                return "ActionBar - Type secondary"
            }
        }

    }

    // MARK: - Published Properties

    @Published var selectedIndex: Int?
    @Published var isEnabledControlsState: Int = 0

    // MARK: - Internal Properties

    var title: String {
        "Actionbar - Type secondary"
    }

    var tabs: [String] {
        ["Default", "Disabled"]
    }

    var actions: [ActionItemBarAction]

    init() {
        actions = [
            ActionItemBarAction(
                image: Image(uiImage: Asset.ActionBar.moreOutline.image),
                imageTintColor: .white,
                backgroundColor: .red,
                style: .secondary,
                text: "Text",
                handler: {}
            ),
            ActionItemBarAction(
                image: Image(uiImage: Asset.ActionBar.arrowUpOutline.image),
                imageStyle: .success,
                style: .secondary,
                text: "Text",
                handler: {}
            ),
            ActionItemBarAction(
                image: Image(uiImage: Asset.ActionBar.arrowDownOutline.image),
                imageStyle: .accent,
                style: .secondary,
                text: "Text",
                handler: {}
            )
        ]
    }

}
