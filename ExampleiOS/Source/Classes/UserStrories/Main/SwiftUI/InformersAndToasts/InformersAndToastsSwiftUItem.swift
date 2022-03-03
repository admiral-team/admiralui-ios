//
//  InformersAndToastsSwiftUItem.swift
//  ExampleiOS
//
//  Created on 28.07.2021.
//

import SwiftUI

@available(iOS 14.0, *)
enum InformersAndToastsSwiftUItem: Int, CaseIterable {
    case informers
    case notifications
    
    var title: String {
        switch self {
        case .informers:
            return "Informers"
        case .notifications:
            return "Notifications"
        }
    }
}
