//
//  PageControlsSwiftUIItem.swift
//  ExampleiOS
//
//  Created on 30.12.2021.
//

@available(iOS 14.0, *)
enum PageControlsSwiftUIItem: Int, CaseIterable {
    case liner
    case circular

    var title: String {
        switch self {
        case .liner:
            return "Liner"
        case .circular:
            return "Circular"
        }
    }
}
