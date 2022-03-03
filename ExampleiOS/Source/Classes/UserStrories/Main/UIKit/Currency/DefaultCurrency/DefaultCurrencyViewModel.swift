//
//  DefaultCurrencyViewModel.swift
//  ExampleiOS
//
//  Created on 24.02.2022.
//

import UIKit
import AdmiralUIKit

final class DefaultCurrencyViewModel {

    // MARK: - Constants

    private enum Constants {
        static let title: String = "Курсы валют"
        static let buttonTitle: String = "Button"
    }

    // MARK: - Internal properties

    let items = [
        CurrencyItem(currencyText: "USD", buyText: "100,88", sellText: "94.65"),
        CurrencyItem(currencyText: "EUR", buyText: "108,88", sellText: "120.65"),
        CurrencyItem(currencyText: "GBR", buyText: "18,88", sellText: "8.65"),
        CurrencyItem(currencyText: "CNY", buyText: "20,88", sellText: "18.65")
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
