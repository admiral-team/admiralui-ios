//
//  IconsFlagsCurrencyViewModel.swift
//  ExampleiOS
//
//  Created on 03.05.2022.
//

import AdmiralSwiftUI
import Combine
import SwiftUI

@available(iOS 14.0.0, *)
final class IconsFlagsCurrencySwiftUIViewModel: ObservableObject {

    struct CurrencyItem: Hashable {
        let id = UUID().uuidString
        let currencyText: String
        let buyText: String
        let sellText: String
        let image: Image
        let firstCellType: CurrencyCellType
        let secondCellType: CurrencyCellType

        func hash(into hasher: inout Hasher) {
            hasher.combine(currencyText)
            hasher.combine(buyText)
            hasher.combine(sellText)
        }

        static func == (lhs: CurrencyItem, rhs: CurrencyItem) -> Bool {
            return lhs.id == rhs.id
        }
    }

    struct CurrencyHeaderItem: Hashable {
        let id = UUID().uuidString
        let currencyText: String
        let buyText: String
        let sellText: String
        let isTextSpacingEnabled: Bool

        func hash(into hasher: inout Hasher) {
            hasher.combine(currencyText)
            hasher.combine(buyText)
            hasher.combine(sellText)
        }

        static func == (lhs: CurrencyHeaderItem, rhs: CurrencyHeaderItem) -> Bool {
            return lhs.id == rhs.id
        }
    }

    // MARK: - Published Properties

    @Published var items: [CurrencyItem]
    @Published var header: CurrencyHeaderItem

    // MARK: - Internal Properties

    var navigationTitle: String {
        "Icons & Flags"
    }

    // MARK: - Initializer

    init() {
        header = CurrencyHeaderItem(
            currencyText: "Валюта",
            buyText: "Купить",
            sellText: "Продать",
            isTextSpacingEnabled: true
        )

        // swiftlint:disable line_length
        items = [
            .init(currencyText: "USD", buyText: "68,65", sellText: "67,88", image: Image(uiImage: Asset.Currency.usa.image), firstCellType: .arrowUp, secondCellType: .arrowUp),
            .init(currencyText: "EUR", buyText: "68,65", sellText: "67,88", image: Image(uiImage: Asset.Currency.european.image), firstCellType: .arrowUp, secondCellType: .arrowUp),
            .init(currencyText: "GBP", buyText: "68,65", sellText: "67,88", image: Image(uiImage: Asset.Currency.britain.image), firstCellType: .arrowUp, secondCellType: .arrowUp),
            .init(currencyText: "CNY", buyText: "68,65", sellText: "67,88", image: Image(uiImage: Asset.Currency.china.image), firstCellType: .arrowUp, secondCellType: .arrowUp)
        ]
    }

}
