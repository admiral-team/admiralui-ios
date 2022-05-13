//
//  SeparatorSwiftUIViewModel.swift
//  ExampleiOS
//
//  Created on 26.04.2022.
//

import AdmiralSwiftUI
import AdmiralUIResources
import Combine
import SwiftUI

@available(iOS 14.0.0, *)
final class SeparatorSwiftUIViewModel: ObservableObject {

    struct SeparatorItem: Hashable {
        let id = UUID().uuidString
        let style: SeparatorStyle
        let title: String

        func hash(into hasher: inout Hasher) {
            hasher.combine(style)
            hasher.combine(title)
        }

        static func == (lhs: SeparatorItem, rhs: SeparatorItem) -> Bool {
            return lhs.id == rhs.id
        }
    }

    // MARK: - Published Properties

    @Published var items: [SeparatorItem]

    // MARK: - Internal Properties

    var title: String {
        "Padding"
    }

    // MARK: - Initializer

    init() {
        items = [
            .init(style: .long, title: "Long"),
            .init(style: .short, title: "Short"),
            .init(style: .empty, title: "Empty")
        ]
    }

}
