//
//  NotificationViewModel.swift
//  ExampleiOS
//
//  Created on 04.05.2022.
//

import Foundation

final class NotificationViewModel {

    enum Items: CaseIterable {
        case toast
        case notifications
        case action

        func getTitle() -> String {
            switch self {
            case .toast:
                return "Toast"
            case .notifications:
                return "Notifications"
            case .action:
                return "Action"
            }
        }
    }

    // MARK: - Internal properties

    var items: [Items] {
        Items.allCases
    }

}
