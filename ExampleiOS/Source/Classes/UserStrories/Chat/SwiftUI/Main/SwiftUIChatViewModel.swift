//
//  SwiftUIChatViewModel.swift
//  ExampleiOS
//
//  Created on 20.04.2022.
//

import Combine

@available(iOS 14.0.0, *)
final class SwiftUIChatViewModel: ObservableObject {

    enum SwiftUIChatItem: String, CaseIterable {
        case input
        case textMessage
        case textOperation
        case uploadingPhoto
        case uploadingFile

        var title: String {
            switch self {
            case .input:
                return "Input"
            case .textMessage:
                return "Text Message"
            case .textOperation:
                return "Text Operation"
            case .uploadingFile:
                return "Uploading File"
            case .uploadingPhoto:
                return "Uploading Photo"
            }
        }

    }

    enum NavigationBarStyle {
        case singlePage
        case fromMainPage
    }

    // MARK: - Internal Properties

    @Published var navigationStyle: NavigationBarStyle

    var title: String {
        "Чат"
    }

    // MARK: - Initializer

    init(navigationStyle: NavigationBarStyle) {
        self.navigationStyle = navigationStyle
    }

}
