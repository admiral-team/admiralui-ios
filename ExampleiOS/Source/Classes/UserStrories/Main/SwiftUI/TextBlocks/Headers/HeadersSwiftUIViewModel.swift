//
//  HeadersSwiftUIViewModel.swift
//  ExampleiOS
//
//  Created on 25.04.2022.
//

import AdmiralSwiftUI
import Combine

@available(iOS 14.0.0, *)
final class HeadersSwiftUIViewModel: ObservableObject {

    struct HeaderItem: Hashable {
        let id = UUID().uuidString
        let header: String
        let title = "Title"
        let subTitle = "Subtitle"
        let buttonTitle = "Button"
        let dropDownHeaderType: DropDownHeaderType = .down
        let headerStyle: HeaderStyle

        func hash(into hasher: inout Hasher) {
            hasher.combine(title)
            hasher.combine(subTitle)
            hasher.combine(buttonTitle)
            hasher.combine(header)
        }

        static func == (lhs: HeaderItem, rhs: HeaderItem) -> Bool {
            return lhs.id == rhs.id
        }
    }

    // MARK: - Published Properties

    @Published var items: [HeaderItem]

    // MARK: - Internal Properties

    var title: String {
        "Header"
    }

    init() {

        items = [
            .init(header: "Title 1", headerStyle: .title),
            .init(header: "Subtitle 2", headerStyle: .body),
            .init(header: "Headline", headerStyle: .headline),
            .init(header: "Headline Secondary", headerStyle: .headlineSecondary)
        ]

    }

}
