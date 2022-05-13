//
//  BottomSheetViewModel.swift
//  ExampleiOS
//
//  Created on 05.05.2022.
//

import AdmiralUIKit
import Foundation

final class BottomSheetViewModel {

    // MARK: - Internal Properties

    var models: [BottomSheetTableViewCellViewModel]

    // MARK: - Initializer

    init() {
        models = [
            BottomSheetTableViewCellViewModel(
                title: "Зарплатная карта",
                isSelected: false,
                subtitle: "56 000.00 ₽",
                additionalTitle: nil,
                image: Asset.Card.visa.image
            ),
            BottomSheetTableViewCellViewModel(
                title: "Карта",
                isSelected: false,
                subtitle: "5 000.00 ₽",
                additionalTitle: nil,
                image: Asset.Card.visa.image
            ),
            BottomSheetTableViewCellViewModel(
                title: "Новая карта",
                isSelected: false,
                subtitle: "200 000.00 ₽ ",
                additionalTitle: nil,
                image: Asset.Card.visa.image
            ),
            BottomSheetTableViewCellViewModel(
                title: "Мультикарта",
                isSelected: false,
                subtitle: "2 000 000.00 ₽ ",
                additionalTitle: "• 6554",
                image: Asset.Card.visa.image
            ),
            BottomSheetTableViewCellViewModel(
                title: "Мультикарта",
                isSelected: false,
                subtitle: "11 000.00 ₽ ",
                additionalTitle: "• 5544",
                image: Asset.Card.visa.image
            ),
            BottomSheetTableViewCellViewModel(
                title: "Карта",
                isSelected: false,
                subtitle: "1000.00 ₽ ",
                additionalTitle: nil,
                image: Asset.Card.visa.image
            )
        ]
    }

}
