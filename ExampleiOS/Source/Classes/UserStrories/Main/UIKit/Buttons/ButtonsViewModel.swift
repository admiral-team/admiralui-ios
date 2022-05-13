//
//  ButtonsViewModel.swift
//  ExampleiOS
//
//  Created on 13.05.2022.
//

import AdmiralUIKit
import Foundation

final class ButtonsViewModel {

    final class ButtonsStorage {

        enum ButtonsType: Equatable {
            case primary
            case secondary
            case ghost
            case rules
        }

        // MARK: - Properties

        let title: String
        var items: [ButtonItem]
        var type: ButtonsType
        var isSelected: Bool = false

        // MARK: - Initializer

        init(items: [ButtonItem], title: String, type: ButtonsType) {
            self.items = items
            self.title = title
            self.type = type
        }

    }

    struct ButtonItem {
        enum Size {
            case big
            case medium
            case small
        }

        let title: String
        let size: Size
    }

    // MARK: - Published Properties

    var items: [ButtonsStorage]

    // MARK: - Internal Properties

    var title: String {
        "Buttons"
    }

    var tabs: [String] {
        ["Default", "Disabled"]
    }

    // MARK: - Initializer

    init() {
        items = [
            .init(items: [
                ButtonItem(title: "Big Button", size: .big),
                ButtonItem(title: "Medium Button", size: .medium),
                ButtonItem(title: "Small Button", size: .small)
            ], title: "Primary", type: .primary),
            .init(items: [
                ButtonItem(title: "Big Button", size: .big),
                ButtonItem(title: "Medium Button", size: .medium),
                ButtonItem(title: "Small Button", size: .small)
            ], title: "Secondary", type: .secondary),
            .init(items: [
                ButtonItem(title: "Medium Button", size: .big),
                ButtonItem(title: "Small Button", size: .small)
            ], title: "Ghost", type: .ghost),
            .init(items: [], title: "Rules", type: .rules)
        ]
    }

}
