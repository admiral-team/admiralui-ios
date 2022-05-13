//
//  NotificationSwiftUIViewModel.swift
//  ExampleiOS
//
//  Created on 27.04.2022.
//

import Combine

@available(iOS 14.0.0, *)
final class NotificationSwiftUIViewModel: ObservableObject {

    enum NotificationsSwiftUIItem: Int, CaseIterable {
        case toast
        case `static`
        case action

        var title: String {
            switch self {
            case .toast:
                return "Toast"
            case .static:
                return "Notifications"
            case .action:
                return "Action"
            }
        }
    }

    // MARK: - Published Properties

    @Published var selection: Int?

    // MARK: - Internal Properties

    var title: String {
        "Informers & Notifications"
    }

}
