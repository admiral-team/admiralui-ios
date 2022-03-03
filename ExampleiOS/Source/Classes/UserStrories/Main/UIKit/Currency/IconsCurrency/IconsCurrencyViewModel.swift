//
//  IconsCurrencyViewModel.swift
//  ExampleiOS
//
//  Created on 24.02.2022.
//

import UIKit
import AdmiralUIKit

final class IconsCurrencyViewModel {

    // MARK: - Constants

    private enum Constants {
        static let title: String = "Курсы валют"
        static let buttonTitle: String = "Button"
    }

    // MARK: - Internal properties


    let items = [
        CurrencyItem(
            currencyText: "USD",
            buyText: "100,88",
            sellText: "94.65",
            sellCellType: .arrowUp,
            buyCellType: .arrowDown
        ),
        CurrencyItem(
            currencyText: "EUR",
            buyText: "108,88",
            sellText: "120.65",
            sellCellType: .arrowUp,
            buyCellType: .arrowDown
        ),
        CurrencyItem(
            currencyText: "GBR",
            buyText: "28,88",
            sellText: "18.65",
            sellCellType: .arrowUp,
            buyCellType: .arrowDown
        ),
        CurrencyItem(
            currencyText: "CNY",
            buyText: "19,88",
            sellText: "9.65",
            sellCellType: .arrowUp,
            buyCellType: .arrowDown
        )
    ]

    let headerItem: CurrencyHeaderItem

    // MARK: - Computed properties

    var title: String {
        Constants.title
    }

    var buttonTitle: String {
        Constants.buttonTitle
    }

    // MARK: - Initializer

    init() {
        headerItem = CurrencyHeaderItem(currencyText: "Валюта", buyText: "Купить", sellText: "Продать", isTextSpacingEnabled: true)
    }

}
