//
//  LinkSwiftUIViewModel.swift
//  ExampleiOS
//
//  Created by on 25.04.2022.
//

import Combine

@available(iOS 14.0.0, *)
final class LinkSwiftUIViewModel: ObservableObject {

    enum LinkItem: Hashable {
        case link(buttonTitle: String)

        static func == (lhs: LinkItem, rhs: LinkItem) -> Bool {
            switch (lhs, rhs) {
            case (.link, .link):
                return true
            }
        }

        func hash(into hasher: inout Hasher) {
            switch self {
            case .link(let buttonTitle):
                hasher.combine(buttonTitle)
            }
        }
    }

    // MARK: - Published Properties

    @Published var items: [LinkItem]

    // MARK: - Internal Properties

    var title: String {
        "Link"
    }

    init() {
        items = [
            .link(buttonTitle: "Подробнее на сайте банка")
        ]
    }

}
