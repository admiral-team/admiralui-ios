//
//  InputNumberSwiftUIViewModel.swift
//  ExampleiOS
//
//  Created by on 13.10.2022.
//  
//

import Foundation

@available(iOS 13.0, *)
final class InputNumberSwiftUIViewModel: ObservableObject {

    enum InputNumberType: Int, CaseIterable {
        case `default`
        case secondary

        var description: String {
            switch self {
            case .default:
                return "Default"
            case .secondary:
                return "Secondary"
            }
        }
    }

    // MARK: - Computed Properties

    var types: [InputNumberType] {
        InputNumberType.allCases
    }

    var navigationTitle: String {
        "Number"
    }

}
