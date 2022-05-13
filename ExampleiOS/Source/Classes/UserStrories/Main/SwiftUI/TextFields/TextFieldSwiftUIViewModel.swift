//
//  TextFieldSwiftUIViewModel.swift
//  ExampleiOS
//
//  Created on 27.04.2022.
//

import Combine

@available(iOS 14.0.0, *)
final class TextFieldSwiftUIViewModel: ObservableObject {

    enum TextFieldsSwiftUIItem: Int, CaseIterable {
        case standard
        case double
        case slider
        case number
        case feedback
        case pincode

        var title: String {
            switch self {
            case .standard:
                return "Standard"
            case .double:
                return "Double"
            case .slider:
                return "Slider"
            case .number:
                return "Number"
            case .feedback:
                return "Feedback"
            case .pincode:
                return "Pincode"
            }
        }
    }

    // MARK: - Published Properties

    @Published var selection: Int?

    // MARK: - Internal Properties

    var title: String {
        "Text Fields"
    }

}
