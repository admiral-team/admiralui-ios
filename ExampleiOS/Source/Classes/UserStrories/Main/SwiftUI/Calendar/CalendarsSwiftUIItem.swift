//
//  CalendarsSwiftUIItem.swift
//  ExampleiOS
//
//  Created on 14.07.2021.
//

import SwiftUI

@available(iOS 14.0, *)
enum CalendarsSwiftUIItem: Int, CaseIterable {
    case horizontal
    case vertical

    var title: String {
        switch self {
        case .horizontal:
            return "Horizontal"
        case .vertical:
            return "Vertical"
        }
    }
}
