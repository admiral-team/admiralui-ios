//
//  PageControlsSwiftUIItem.swift
//  ExampleiOS
//
//  Created on 30.12.2021.
//

@available(iOS 14.0, *)
enum PageControlsSwiftUIItem: Int, CaseIterable {
    case circular

    var title: String {
        switch self {
        case .circular:
            return "Circular"
        }
    }
}
