//
//  CheckSwiftUI.swift
//  AdmiralSwiftUITests
//
//  Created by on 14.02.2023.
//  
//

import XCTest

enum Framework: String {
    case UIKit = "0"
    case switUI = "1"
}

func checkFramework(width app: XCUIApplication, framework: Framework) {
        app.buttons["SeatingTabBarItem"].tap()
        let swiftUISwitcher = app.switches["SwitchToSwiftUI"]
        
        if swiftUISwitcher.value as? String != framework.rawValue {
            swiftUISwitcher.tap()
        }
        
        app.buttons["MainTabBarItem"].tap()
}
