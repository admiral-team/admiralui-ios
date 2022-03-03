//
//  SwiftUIChatItem.swift
//  ExampleiOS
//
//  Created on 08.11.2021.
//

import SwiftUI

@available(iOS 14.0, *)
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
