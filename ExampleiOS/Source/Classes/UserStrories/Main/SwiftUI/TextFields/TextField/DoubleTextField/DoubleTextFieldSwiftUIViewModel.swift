//
//  DoubleTextFieldSwiftUIViewModel.swift
//  ExampleiOS
//
//  Created on 27.04.2022.
//

import AdmiralSwiftUI
import AdmiralUIResources
import Combine
import SwiftUI

@available(iOS 14.0.0, *)
final class DoubleTextFieldSwiftUIViewModel: ObservableObject {

    // MARK: - Published Properties

    @Published var controlsState: Int = 0
    @Published var firstText: String? = "Text"
    @Published var secondText: String? = "Text"

    @Published var thirdText: String? = "Text"
    @Published var fourText: String? = "Text"
    @Published var state: TextInputState = .normal

    // MARK: - Internal Properties

    var title: String {
        "Double"
    }

    var tabItems: [String] {
        ["Default", "Error", "Disabled", "Read Only"]
    }

    // MARK: - Internal Methods

    func someText() -> String {
        var text = ""
        for index in 0..<1000 {
            text += "\(index)"
        }
        return text
    }

}
