//
//  UserSettingService.swift
//  ExampleiOS
//
//  Created on 29.03.2021.
//

import Foundation

protocol UserSettingServiceProtocol {
    var isOnboardingFinish: Bool { get }
    
    func setOnboardingFinish()
}

class UserSettingService: UserSettingServiceProtocol {
    
    enum Constants {
        static let isOnboardingFinishKey = "isOnboardingFinish"
    }
    
    var isOnboardingFinish: Bool {
        return defaults.bool(forKey: Constants.isOnboardingFinishKey)
    }
    
    // MARK: - Private Properties
    
    private let defaults = UserDefaults.standard
    
    // MARK: - Internal Methods
    
    func setOnboardingFinish() {
        defaults.setValue(true, forKey: Constants.isOnboardingFinishKey)
    }
    
}
