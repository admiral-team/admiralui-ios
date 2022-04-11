//
//  AlertOnboardingItem.swift
//  ExampleiOS
//
//  Created on 16.02.2022.
//

import SwiftUI

@available(iOS 14.0, *)
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
