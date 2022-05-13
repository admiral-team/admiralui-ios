//
//  InputNumberSwiftUIViewModel.swift
//  ExampleiOS
//
//  Created on 27.04.2022.
//

import AdmiralSwiftUI
import Combine

@available(iOS 14.0.0, *)
final class InputNumberSwiftUIViewModel: ObservableObject {

    // MARK: - Published Properties

    @Published var isEnabledControlsState: Int = 0
    @Published var startValue: Double = 0

    // MARK: - Internal Properties

    var title: String {
        "Number"
    }

    var tabItems: [String] {
        ["Default", "Disabled"]
    }

}
