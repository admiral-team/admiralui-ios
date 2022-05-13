//
//  StatusHistorySmallViewModel.swift
//  ExampleiOS
//
//  Created on 07.05.2022.
//

import AdmiralUIKit
import Foundation

final class StatusHistorySmallViewModel {

    enum StatusHistory: String, CaseIterable {
        case hold = "Hold"
        case success = "Success"
        case attention = "Attention"
        case error = "Error"
        case sale = "Sale"
    }

    var title: String {
        "Константин Н."
    }

    var text: String {
        "Image Count"
    }

    var date: String {
        "10 Июля 2020, 20:31"
    }

    var sum: String {
        "-2 500 ₽"
    }

    var crossOutSum: String {
        "5 000 ₽"
    }

    var subtitle: String {
        "Входящие переводы"
    }

    var statusText: String {
        "В обработке"
    }

}
