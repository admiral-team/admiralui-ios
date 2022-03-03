//
//  AlertOnboardingViewModel.swift
//  ExampleiOS
//
//  Created on 16.02.2022.
//

import Foundation

final class AlertOnboardingViewModel {

    enum Items: CaseIterable {
        case alert
        case error
        case onboarding
        case zeroScreen

        func getTitle() -> String {
            switch self {
            case .alert:
                return "Alert"
            case .error:
                return "Error View"
            case .onboarding:
                return "Onboarding"
            case .zeroScreen:
                return "Zeroscreen"
            }
        }
    }

    // MARK: - Internal properties

    var items: [Items] {
        Items.allCases
    }

}
