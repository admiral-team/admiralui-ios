//
//  CurrencyItem.swift
//  ExampleiOS
//
//  Created on 24.02.2022.
//

import UIKit
import AdmiralUIKit

struct CurrencyItem {
    let image: UIImage?
    let currencyText: String?
    let buyText: String?
    let sellText: String?
    let sellCellType: CurrencyCellType?
    let buyCellType: CurrencyCellType?

    init(
        image: UIImage? = nil,
        currencyText: String? = nil,
        buyText: String? = nil,
        sellText: String? = nil,
        sellCellType: CurrencyCellType? = nil,
        buyCellType: CurrencyCellType? = nil
    ) {
        self.image = image
        self.currencyText = currencyText
        self.buyText = buyText
        self.sellText = sellText
        self.sellCellType = sellCellType
        self.buyCellType = buyCellType
    }
}
