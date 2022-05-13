//
//  PageControlsSwiftUIViewModel.swift
//  ExampleiOS
//
//  Created on 25.04.2022.
//

import AdmiralSwiftUI
import Combine
import SwiftUI

@available(iOS 14.0.0, *)
final class PageControlsSwiftUIViewModel: ObservableObject {

    enum PageControlsSwiftUIItem: Int, CaseIterable {
        case circular

        var title: String {
            switch self {
            case .circular:
                return "Circular"
            }
        }
    }

    // MARK: - Published Properties

    @Published var selection: Int?

    // MARK: - Internal Properties

    var navigationTitle: String {
        "Page Controls"
    }

    var pageItems: [PageControlsSwiftUIItem] {
        PageControlsSwiftUIItem.allCases
    }
    
}
