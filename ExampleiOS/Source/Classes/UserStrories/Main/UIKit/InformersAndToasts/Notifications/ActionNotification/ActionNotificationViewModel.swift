//
//  ActionNotificationViewModel.swift
//  ExampleiOS
//
//  Created on 03.05.2022.
//

import Foundation

final class ActionNotificationViewModel {

    // MARK: - Internal Properties

    // swiftlint:disable line_length
    var text: String {
        "Компонент используется для отмены совершенного действия, появляется внизу экрана поверх контента с обратным отсчетом времени в 5 секунд сразу после совершения какого-либо действия."
    }

    var title: String {
        "Показать Action"
    }

    var toastTitle: String {
        "Сообщение будет удалено"
    }

    var closeTitle: String {
        "Отмена"
    }

}
