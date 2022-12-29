//
//  CalendarsSwiftUIItem.swift
//  ExampleiOS
//
//  Created on 14.07.2021.
//

import SwiftUI

@available(iOS 14.0, *)
enum CalendarsSwiftUIItem: Int, CaseIterable {
    case vertical
    case horizontal

    var title: String {
        switch self {
        case .vertical:
            return "Vertical"
        case .horizontal:
            return "Horizontal"
        }
    }
}
