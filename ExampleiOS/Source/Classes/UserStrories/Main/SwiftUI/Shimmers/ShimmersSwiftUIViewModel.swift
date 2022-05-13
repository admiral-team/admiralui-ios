//
//  ShimmersSwiftUIViewModel.swift
//  ExampleiOS
//
//  Created on 25.04.2022.
//

import AdmiralUIResources
import Combine
import SwiftUI

@available(iOS 14.0.0, *)
final class ShimmersSwiftUIViewModel: ObservableObject {

    struct ShimmerItem: Hashable {
        enum ActiveType {
            case imageCardList
            case titleMore
            case iconList
        }

        let id = UUID().uuidString
        let title: String = "Card"
        let detail: String = "50 000.00 ₽"
        let isActive: ActiveType
        let image = Image(uiImage: Asset.Card.visa.image)

        func hash(into hasher: inout Hasher) {
            hasher.combine(title)
            hasher.combine(detail)
        }

        static func == (lhs: ShimmerItem, rhs: ShimmerItem) -> Bool {
            return lhs.id == rhs.id
        }
    }

    // MARK: - Published Properties

    @Published var isEnabledControlsState: Int = 0
    @Published var items: [ShimmerItem]

    // MARK: - Internal Properties

    var title: String {
        "Shimmers"
    }

    init() {
        items = [
            ShimmerItem(isActive: .imageCardList),
            ShimmerItem(isActive: .titleMore),
            ShimmerItem(isActive: .iconList)
        ]
    }

}
