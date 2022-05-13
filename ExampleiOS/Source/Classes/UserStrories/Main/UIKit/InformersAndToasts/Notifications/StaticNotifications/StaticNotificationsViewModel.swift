//
//  StaticNotificationsViewModel.swift
//  ExampleiOS
//
//  Created on 05.05.2022.
//

import Foundation

final class StaticNotificationsViewModel {

    // MARK: - Constants

    enum Constants {
        static let text = "At breakpoint boundaries, mini units divide the screen into a fixed master grid."
        static let linkText = "Link text"
    }

    // MARK: - Internal Properties

    var items: [StaticNotificationViewModel]

    // MARK: - Initializer

    init() {
        items = [
            StaticNotificationViewModel(title: "Default",
                                               text: Constants.text,
                                               linkText: Constants.linkText,
                                               type: .additional,
                                               imageType: .info),
            StaticNotificationViewModel(title: "Success",
                                               text: Constants.text,
                                               linkText: Constants.linkText,
                                               type: .success,
                                               imageType: .success),
            StaticNotificationViewModel(title: "Attention",
                                               text: Constants.text,
                                               linkText: Constants.linkText,
                                               type: .attention,
                                               imageType: .attention),
            StaticNotificationViewModel(title: "Error",
                                               text: Constants.text,
                                               linkText: Constants.linkText,
                                               type: .error,
                                               imageType: .error)
        ]

    }

}
