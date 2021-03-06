//
//  MapButton.swift
//  AdmiralUIResources
//
//  Created on 26.10.2021.
//

import XCTest
import SwiftUI
import SnapshotTesting
import AdmiralTheme
import AdmiralUIResources
@testable import AdmiralSwiftUI

private struct MapButtonWrapper<T: View>: View {

    // MARK: - Properties
    let view: T

    // MARK: - Layout
    var body: some View {
        view
            .frame(width: 60, height: 60)
    }

}

final class MapButtonSnapshotTests: XCTestCase {

    override func setUp() {
        super.setUp()
        Appearance.prepare()
    }
    
    // MARK: Default Theme
    
    func testCheckButton() {
        SwiftUIThemeManager.shared.theme = .default
        let mapButton = Button(action: {}, label: {}).buttonStyle(MapButtonStyle(type: .plus))
        checkMapButton(view: mapButton, named: "default", testName: "MapButtonPlus")
    }

    func testCheckButtonMinus() {
        SwiftUIThemeManager.shared.theme = .default
        let mapButton = Button(action: {}, label: {}).buttonStyle(MapButtonStyle(type: .minus))
        checkMapButton(view: mapButton, named: "default", testName: "MapButtonMinus")
    }

    func testCheckButtonLocation() {
        SwiftUIThemeManager.shared.theme = .default
        let mapButton = Button(action: {}, label: {}).buttonStyle(MapButtonStyle(type: .location))
        checkMapButton(view: mapButton, named: "default", testName: "MapButtonLocation")
    }
    
    // MARK: Dark Theme
    
    func testCheckButtonDarkTheme() {
        SwiftUIThemeManager.shared.theme = .dark
        let mapButton = Button(action: {}, label: {}).buttonStyle(MapButtonStyle(type: .plus))
        checkMapButton(view: mapButton, named: "defaultDarkTheme", testName: "MapButtonPlus")
    }

    func testCheckButtonMinusDarkTheme() {
        SwiftUIThemeManager.shared.theme = .dark
        let mapButton = Button(action: {}, label: {}).buttonStyle(MapButtonStyle(type: .minus))
        checkMapButton(view: mapButton, named: "defaultDarkTheme", testName: "MapButtonMinus")
    }

    func testCheckButtonLocationDarkTheme() {
        SwiftUIThemeManager.shared.theme = .dark
        let mapButton = Button(action: {}, label: {}).buttonStyle(MapButtonStyle(type: .location))
        checkMapButton(view: mapButton, named: "defaultDarkTheme", testName: "MapButtonLocation")
    }

}

private extension MapButtonSnapshotTests {

    func checkMapButton<T: View>(view: T, named: String, testName: String) {
        let mapButtonWrapper = MapButtonWrapper(view: view)
        let view = UIHostingController(rootView: mapButtonWrapper)
        let result = verifySnapshot(
            matching: view,
            as: .image,
            named: named,
            file: getFilePath(),
            testName: testName)
        XCTAssertNil(result)
    }

}
