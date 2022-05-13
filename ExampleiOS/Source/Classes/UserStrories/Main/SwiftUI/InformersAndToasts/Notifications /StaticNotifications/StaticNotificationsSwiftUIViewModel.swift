//
//  StaticNotificationsSwiftUIViewModel.swift
//  ExampleiOS
//
//  Created on 27.04.2022.
//

import AdmiralSwiftUI
import AdmiralUIResources
import Combine
import SwiftUI

@available(iOS 14.0.0, *)
final class StaticNotificationsSwiftUIViewModel: ObservableObject {

    struct NotificationItem: Hashable {
        let title: String
        let id = UUID().uuidString
        let text = "At breakpoint boundaries, mini units divide the screen into a fixed master grid."
        let linkText = "Link Text"
        let type: ToastViewType
        let imageType: ToastImageType
        let imageColorType: ToastImageType

        func hash(into hasher: inout Hasher) {
            hasher.combine(type)
            hasher.combine(imageType)
            hasher.combine(imageColorType)
        }

        static func == (lhs: NotificationItem, rhs: NotificationItem) -> Bool {
            return lhs.id == rhs.id
        }
    }

    // MARK: - Published Properties

    @Published var items: [NotificationItem]

    // MARK: - Internal Properties

    var title: String {
        "Static"
    }

    // MARK: - Initializer

    init() {
        items = [
            .init(title: "Default", type: .default, imageType: .info, imageColorType: .info),
            .init(title: "Success", type: .success, imageType: .success, imageColorType: .success),
            .init(title: "Attention", type: .attention, imageType: .attention, imageColorType: .attention),
            .init(title: "Error", type: .error, imageType: .error, imageColorType: .error)
        ]
    }

}
