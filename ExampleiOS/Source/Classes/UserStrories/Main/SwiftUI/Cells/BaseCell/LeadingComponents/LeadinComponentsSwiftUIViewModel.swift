//
//  LeadinComponentsSwiftUIViewModel.swift
//  ExampleiOS
//
//  Created on 03.05.2022.
//

import Combine
import Foundation

@available(iOS 14.0.0, *)
final class LeadinComponentsSwiftUIViewModel: ObservableObject {

    struct LeadinComponentItem: Hashable {

        enum CellTypeList {
            case title
            case titleSubtitle(subTitle: String)
            case subtitle(subTitle: String)
            case titleMoreDetail
            case titleSubtitleButton
        }

        let id = UUID().uuidString
        let type: CellTypeList

        func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }

        static func == (lhs: LeadinComponentItem, rhs: LeadinComponentItem) -> Bool {
            return lhs.id == rhs.id
        }
    }

    // MARK: - Published Properties

    @Published var selectedIndex: Int?
    @Published var isEnabledControlsState: Int = 0
    @Published var items: [LeadinComponentItem]

    // MARK: - Internal Properties

    var navigationTitle: String {
        "Leading elements"
    }

    var tabsItems: [String] {
        ["Default", "Disabled"]
    }

    // MARK: - Initializer

    init() {
        items = [
            .init(type: .title),
            .init(type: .titleSubtitle(subTitle: "Subtitle")),
            .init(type: .subtitle(subTitle: "Subtitle")),
            .init(type: .titleMoreDetail),
            .init(type: .titleSubtitleButton)
        ]
    }

}
