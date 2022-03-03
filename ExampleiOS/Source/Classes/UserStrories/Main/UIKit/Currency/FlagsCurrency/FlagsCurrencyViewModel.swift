//
//  FlagsCurrencuViewModel.swift
//  ExampleiOS
//
//  Created on 24.02.2022.
//

import UIKit
import AdmiralUIKit

final class FlagsCurrencyViewModel {

    // MARK: - Constants

    private enum Constants {
        static let title: String = "Курсы валют"
        static let buttonTitle: String = "Button"
    }

    // MARK: - Internal properties


    let items = [
        CurrencyItem(
            image: Asset.Currency.usa.image,
            currencyText: "USD",
            buyText: "100,88",
            sellText: "94.65"
        ),
        CurrencyItem(
            image: Asset.Currency.european.image,
            currencyText: "EUR",
            buyText: "108,88",
            sellText: "120.65"
        ),
        CurrencyItem(
            image: Asset.Currency.britain.image,
            currencyText: "GBR",
            buyText: "28,88",
            sellText: "18.65"
        ),
        CurrencyItem(
            image: Asset.Currency.china.image,
            currencyText: "CNY",
            buyText: "19,88",
            sellText: "9.65"
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
        headerItem = CurrencyHeaderItem(currencyText: "Валюта", buyText: "Купить", sellText: "Продать", isTextSpacingEnabled: false)
    }

}
