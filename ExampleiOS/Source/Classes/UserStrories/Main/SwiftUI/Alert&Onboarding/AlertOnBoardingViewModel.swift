//
//  AlertOnBoardingViewModel.swift
//  ExampleiOS
//
//  Created by on 20.04.2022.
//

import Combine

@available(iOS 14.0.0, *)
final class AlertOnBoardingViewModel: ObservableObject {

    enum AlertOnboardingItem: CaseIterable {
        case alert
        case onboarding
        case zeroScreen
        case error

        var title: String {
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

    // MARK: - Internal Properties

    var title: String {
        "Alert&Onboarding"
    }

}
