//
//  AlertSwiftUIViewModel.swift
//  ExampleiOS
//
//  Created on 20.04.2022.
//

import Combine

@available(iOS 14.0.0, *)
final class AlertSwiftUIViewModel: ObservableObject {
    // swiftlint:disable all

    // MARK: - Published Properties

    @Published var show = false

    // MARK: - Internal Properties

    var navigationTitle: String {
        "Alert"
    }

    var description: String {
        "Всплывающие окна поверх контента, часто содержат короткое информирующее сообщение, иллюстрацию и кнопки основгого или альтернативного действия. Для вызова Alert, нажмите кнопку."
    }

    var alertTitle: String {
        "Заголовок в одну \nили две строки"
    }

    var alertMessage: String {
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
    }

    var alertButtonTitle: String {
        "Действие"
    }
    
}
