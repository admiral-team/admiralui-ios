//
//  ActionBarSwiftUIItem.swift
//  ExampleiOS
//
//  Created on 08.02.2022.
//

import SwiftUI

@available(iOS 14.0, *)
enum ActionBarSwiftUIItem: String, CaseIterable {
    case `default`
    case secondary

    var title: String {
        switch self {
        case .default:
            return "ActionBar - Type default"
        case .secondary:
            return "ActionBar - Type secondary"
        }
    }

}
