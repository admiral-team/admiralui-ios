//
//  FeedbackInputSwiftUIViewViewModel.swift
//  ExampleiOS
//
//  Created on 27.04.2022.
//

import Combine

@available(iOS 14.0.0, *)
final class FeedbackInputSwiftUIViewViewModel: ObservableObject {

    // MARK: - Published Properties

    @Published var isEnabledControlsState: Int = 0
    @Published var cursorPosition: Int = 0

    // MARK: - Internal Properties

    var title: String {
        "Feedback"
    }

    var tabItems: [String] {
        ["Default", "Disabled"]
    }

}
