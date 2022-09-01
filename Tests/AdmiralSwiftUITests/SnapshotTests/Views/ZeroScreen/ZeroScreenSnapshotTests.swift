//
//  ZeroScreen.swift
//  AdmiralSwiftUITests
//
//  Created on 10.11.2021.
//

import XCTest
import SwiftUI
import SnapshotTesting
import AdmiralTheme
import AdmiralUIResources
@testable import AdmiralSwiftUI

private struct ZeroScreenWrapper<T: View>: View {

    // MARK: - Properties
    let view: T

    // MARK: - Layout
    var body: some View {
        view
            .frame(width: 300, height: 300)
    }

}

final class ZeroScreenSnapshotTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        Appearance.prepare()
    }
    
    // MARK: DefaultTheme
    func testZeroScreenDefaultTheme() {
        Appearance.shared.theme = .default
        let view = createZeroScreen()
        checkZeroScreen(view: view, named: "DefaultTheme", testName: "ZeroScreen")
    }
    
    // MARK: DarkTheme

    func testZeroScreenDarkTheme() {
        Appearance.shared.theme = .dark
        let view = createZeroScreen()
        checkZeroScreen(view: view, named: "DarkTheme", testName: "ZeroScreen")
    }
    
    func createZeroScreen() -> some View {
        let zeroScreenView = ZeroScreenView(title: "ZeroScreen",
                                        subtitle: "CheckMe",
                                        buttonTitle: "Button",
                                        buttonAction: {})
        return zeroScreenView
    }
    
}

private extension ZeroScreenSnapshotTests {

    func checkZeroScreen<T: View>(view: T, named: String, testName: String, disabled: Bool = false) {
        let zeroScreenWrapper = ZeroScreenWrapper(view: view)
        let view = UIHostingController(rootView: zeroScreenWrapper)
        let result = verifySnapshot(
            matching: view,
            as: .image,
            named: named,
            file: getFilePath(),
            testName: testName)
        XCTAssertNil(result)
    }

}
