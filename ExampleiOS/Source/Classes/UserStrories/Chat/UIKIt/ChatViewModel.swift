//
//  ChatViewModel.swift
//  ExampleiOS
//
//  Created on 27.01.2022.
//

import Foundation

final class ChatViewModel {

    enum Items: CaseIterable {
        case input
        case message
        case operation
        case uploadingPhoto
        case uploadingFiles

        func getTitle() -> String {
            switch self {
            case .input:
                return "Input"
            case .message:
                return "Text Message"
            case .operation:
                return "Text Operation"
            case .uploadingPhoto:
                return "Uploading Photo"
            case .uploadingFiles:
                return "Uploading File"
            }
        }
    }

    // MARK: - Internal properties

    var items: [Items] {
        Items.allCases
    }

}
