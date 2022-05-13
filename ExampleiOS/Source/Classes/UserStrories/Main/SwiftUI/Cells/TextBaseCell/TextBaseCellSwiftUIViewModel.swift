//
//  TextBaseCellSwiftUIViewModel.swift
//  ExampleiOS
//
//  Created on 03.05.2022.
//

import AdmiralSwiftUI
import Combine
import SwiftUI

@available(iOS 14.0.0, *)
final class TextBaseCellSwiftUIViewModel: ObservableObject {

    struct TextBaseCellItem: Hashable {

        enum CellType {
            case text
            case icon(image: Image)
        }

        let id = UUID().uuidString
        let title: String
        let text: String = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
        let type: CellType

        func hash(into hasher: inout Hasher) {
            hasher.combine(text)
        }

        static func == (lhs: TextBaseCellItem, rhs: TextBaseCellItem) -> Bool {
            return lhs.id == rhs.id
        }
    }

    // MARK: - Published Properties

    @Published var isEnabledControlsState: Int = 0
    @Published var items: [TextBaseCellItem]

    // MARK: - Internal Properties

    var navigationTitle: String {
        "Text Cells"
    }

    var tabsItems: [String] {
        ["Default", "Disabled"]
    }

    // MARK: - Initializer

    init() {
        items = [
            .init(title: "Text Cell", type: .text),
            .init(title: "Text Cell vs Icon", type: .icon(image: Image(uiImage: Asset.Card.info.image)))
        ]
    }

}
