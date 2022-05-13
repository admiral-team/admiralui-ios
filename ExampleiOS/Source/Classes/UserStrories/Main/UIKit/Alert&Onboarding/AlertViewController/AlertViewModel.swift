//
//  AlertViewModel.swift
//  ExampleiOS
//
//  Created on 05.05.2022.
//

import Foundation

final class AlertViewModel {
    // swiftlint:disable all

    // MARK: - Internal Properties

    var navigationTitle: String {
        "Alert"
    }

    var description: String {
        "Всплывающие окна поверх контента, часто содержат короткое информирующее сообщение, иллюстрацию и кнопки основгого или альтернативного действия. Для вызова Alert, нажмите кнопку."
    }

    var alertTitle: String {
        "Заголовок в одну или две строки"
    }

    var alertMessage: String {
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
    }

    var alertButtonTitle: String {
        "Действие"
    }

}
