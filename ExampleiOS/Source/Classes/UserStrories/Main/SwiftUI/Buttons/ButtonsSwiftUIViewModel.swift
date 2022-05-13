//
//  ButtonsSwiftUIViewModel.swift
//  ExampleiOS
//
//  Created on 27.04.2022.
//

import AdmiralSwiftUI
import AdmiralUIResources
import Combine
import SwiftUI

@available(iOS 14.0.0, *)
final class ButtonsSwiftUIViewModel: ObservableObject {

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

    struct ButtonItem: Hashable {
        let id = UUID().uuidString
        let title: String
        var isLoading: Bool
        let size: ButtonSizeType

        func hash(into hasher: inout Hasher) {
            hasher.combine(title)
            hasher.combine(isLoading)
            hasher.combine(size)
        }

        static func == (lhs: ButtonItem, rhs: ButtonItem) -> Bool {
            return lhs.id == rhs.id
        }
    }

    // MARK: - Published Properties

    @Published var items: [ButtonsStorage]
    @Published var isEnabledControlsState: Int = 0

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
                ButtonItem(title: "Big Button", isLoading: false, size: .big),
                ButtonItem(title: "Medium Button", isLoading: false, size: .medium),
                ButtonItem(title: "Small Button", isLoading: false, size: .small)
            ], title: "Primary", type: .primary),
            .init(items: [
                ButtonItem(title: "Big Button", isLoading: false, size: .big),
                ButtonItem(title: "Medium Button", isLoading: false, size: .medium),
                ButtonItem(title: "Small Button", isLoading: false, size: .small)
            ], title: "Secondary", type: .secondary),
            .init(items: [
                ButtonItem(title: "Medium Button", isLoading: false, size: .big),
                ButtonItem(title: "Small Button", isLoading: false, size: .small)
            ], title: "Ghost", type: .ghost),
            .init(items: [], title: "Rules", type: .rules)
        ]
    }

}
