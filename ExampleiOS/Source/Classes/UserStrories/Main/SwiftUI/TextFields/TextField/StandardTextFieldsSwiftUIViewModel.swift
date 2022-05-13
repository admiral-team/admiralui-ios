//
//  StandardTextFieldsSwiftUIViewModel.swift
//  ExampleiOS
//
//  Created on 27.04.2022.
//

import Combine

@available(iOS 14.0.0, *)
final class StandardTextFieldsSwiftUIViewModel: ObservableObject {

    enum StandardTextFieldsSwiftUIItem: Int, CaseIterable {
        case standard
        case cardNumber
        case smsCode

        var title: String {
            switch self {
            case .standard:
                return "Standard"
            case .cardNumber:
                return "Card Number"
            case .smsCode:
                return "SMS Code"
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
