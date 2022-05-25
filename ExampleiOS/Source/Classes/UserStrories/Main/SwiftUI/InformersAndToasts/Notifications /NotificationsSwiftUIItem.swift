//
//  NotificationsSwiftUIItem.swift
//  ExampleiOS
//
//  Created on 28.07.2021.
//

import SwiftUI

@available(iOS 14.0, *)
enum NotificationsSwiftUIItem: Int, CaseIterable {
    case toast
    case `static`
    case action
    
    var title: String {
        switch self {
        case .toast:
            return "Toast"
        case .static:
            return "Static"
        case .action:
            return "Action"
        }
    }
}
