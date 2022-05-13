//
//  ToastNotificationsViewModel.swift
//  ExampleiOS
//
//  Created on 12.05.2022.
//

import Foundation

final class ToastNotificationsUIKitViewModel {

    // MARK: - Internal Properties

    // swiftlint:disable line_length
    var text: String {
        "Компонент появляется в верхней части страницы на мобильных девайсах и справа в верхней части страницы на планшетах только внутри приложения, автоматически исчезает по таймауту, по свайпу вверх или по нажатию на иконку закрытия если она присутствует.\n\nКомпонентов на странице может быть несколько, если они приходят одновременно наслаиваясь друг на друга и исчезают по собственному таймауту. При тапу на группу таких уведомлений они раскрываются в список."
    }

    var title: String {
        "Показать Toast"
    }

    var toastTitle: String {
        "At breakpoint boundaries, mini units divide the screen into a fixed master grid."
    }

    var linkText: String {
        "Link text"
    }

}
