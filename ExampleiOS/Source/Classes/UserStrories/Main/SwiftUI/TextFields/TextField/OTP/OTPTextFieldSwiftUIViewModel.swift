//
//  OTPTextFieldSwiftUIViewModel.swift
//  ExampleiOS
//
//  Created on 27.04.2022.
//

import AdmiralSwiftUI
import Combine

@available(iOS 14.0.0, *)
final class OTPTextFieldSwiftUIViewModel: ObservableObject {

    // MARK: - Published Properties

    @Published var text: String? = ""
    @Published var controlsState: Int = 0
    @Published var isResponder = true
    @Published var state: TextInputState = .normal

    // MARK: - Internal Properties

    var title: String {
        "SMS Code"
    }

    var tabItems: [String] {
        ["Default", "Error", "Disabled"]
    }

}
