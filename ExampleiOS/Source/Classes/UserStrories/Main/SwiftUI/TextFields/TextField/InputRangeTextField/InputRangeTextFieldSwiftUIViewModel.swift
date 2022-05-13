//
//  InputRangeTextFieldSwiftUIViewModel.swift
//  ExampleiOS
//
//  Created on 27.04.2022.
//

import AdmiralSwiftUI
import AdmiralUIResources
import Combine
import SwiftUI

@available(iOS 14.0.0, *)
final class InputRangeTextFieldSwiftUIViewModel: ObservableObject {

    // MARK: - Published Properties

    @Published var text: String? = "100"

    @Published var contentFrom: String? = "100"
    @Published var contentTo: String? = "300"

    @Published var controlsState: Int = 0
    @Published var state: TextInputState = .normal
    @Published var isResponder = false
    @Published var isResponderTo = false
    @Published var isResponderFrom = false

    // MARK: - Internal Properties

    var title: String {
        "Slider"
    }

    var tabItems: [String] {
        ["Default", "Error", "Disabled"]
    }

}
