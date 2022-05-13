//
//  ActionBarSwiftUIDefaultViewModel.swift
//  ExampleiOS
//
//  Created on 03.05.2022.
//

import AdmiralSwiftUI
import Combine
import SwiftUI

@available(iOS 14.0.0, *)
final class ActionBarSwiftUIDefaultViewModel: ObservableObject {

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
        "Actionbar - Type default"
    }

    var tabs: [String] {
        ["Default", "Disabled"]
    }

    var actions: [ActionItemBarAction]

    init() {
        actions = [
            ActionItemBarAction(
                image: Image(uiImage: Asset.ActionBar.moreOutline.image),
                imageStyle: .accent,
                handler: {}),
            ActionItemBarAction(
                image: Image(uiImage: Asset.ActionBar.arrowUpOutline.image),
                imageStyle: .primary,
                handler: {}),
            ActionItemBarAction(
                image: Image(uiImage: Asset.ActionBar.arrowDownOutline.image),
                imageStyle: .primary,
                handler: {}),
            ActionItemBarAction(
                image: Image(uiImage: Asset.ActionBar.union.image),
                imageStyle: .accent,
                handler: {}),
            ActionItemBarAction(
                image: Image(uiImage: Asset.ActionBar.closeOutline.image),
                imageStyle: .error,
                handler: {})
        ]
    }

}
