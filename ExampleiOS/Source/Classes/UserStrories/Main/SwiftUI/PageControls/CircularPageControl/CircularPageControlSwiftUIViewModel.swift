//
//  CircularPageControlSwiftUIViewModel.swift
//  ExampleiOS
//
//  Created by on 25.04.2022.
//

import AdmiralSwiftUI
import Combine
import SwiftUI

@available(iOS 14.0.0, *)
final class CircularPageControlSwiftUIViewModel: ObservableObject {

    // MARK: - Published Properties

    @Published var isEnabledControlsState: Int = 0
    @Published var totalPages: Int = 0
    @Published var step: Int = 0

    // MARK: - Internal Properties

    var navigationTitle: String {
        "Circular Page Control"
    }

    var items: [String] {
        ["One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Eleven"]
    }

}
