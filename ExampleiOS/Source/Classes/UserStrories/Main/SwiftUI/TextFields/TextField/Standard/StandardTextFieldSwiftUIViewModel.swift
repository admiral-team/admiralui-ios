//
//  StandardTextFieldSwiftUIViewModel.swift
//  ExampleiOS
//
//  Created on 27.04.2022.
//

import AdmiralSwiftUI
import AdmiralUIResources
import Combine
import SwiftUI

@available(iOS 14.0.0, *)
final class StandardTextFieldSwiftUIViewModel: ObservableObject {

    // MARK: - Published Properties

    @Published var formatText: String? = "Text"
    @Published var text: String? = "Text"
    @Published var secureText: String? = "Text"
    @Published var viewText: String? = "Text"
    @Published var controlsState: Int = 0
    @Published var state: TextInputState = .normal

    @Published var isResponderTextField: Bool = false
    @Published var isResponderSecureTextField: Bool = false
    @Published var isResponderTextView: Bool = false

    // MARK: - Internal Properties

    var title: String {
        "Standard"
    }

    var tabItems: [String] {
        ["Default", "Error", "Disabled", "Read Only"]
    }

}
