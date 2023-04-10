//
//  ZeroScreenSnapshotTest.swift
//  AdmiralUIResources
//
//  Created on 17.02.2022.
//

import XCTest
import SnapshotTesting
import AdmiralCore
import AdmiralTheme
import AdmiralUIResources
@testable import AdmiralUIKit

class ZeroScreenSnapshotTest: XCTestCase {
    
    private enum Constants {
        static let title = "Title Center"
        static let subTitle = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
        static let buttonTitle = "Хорошо"
    }
    
    override func setUp() {
        super.setUp()
        Appearance.prepare()
    }
    
    // MARK: - Theme
    
    private lazy var theme: AppTheme = {
        let theme = Appearance.shared.theme
        return theme
    }()
    
    // MARK: - View
      
    func testZeroScreenDefaultTheme() {
        let view = createView(appTheme: .default)
        checkView(view: view, named: "DefaultTheme", testName: "testZeroScreen")
    }
    
    func testZeroScreenDarkTheme() {
        let view = createView(appTheme: .dark)
        checkView(view: view, named: "DarkTheme", testName: "testZeroScreen")
    }
    
    // MARK: - Private Methods
    
    private func createView(appTheme: AppTheme) -> UIView {
        let view = ZeroScreenView(
            image: Asset.Documents.Solid.accountDetailSolid.image,
            title: Constants.title,
            subTitle: Constants.subTitle,
            buttonTitle: Constants.buttonTitle)
        
        view.frame.size = CGSize(width: 320.0, height: 620.0)
        theme = appTheme
        view.apply(theme: theme)

        
        return view
    }
    
    private func checkView(view: UIView, named: String, testName: String) {
        let result = verifySnapshot(
            matching: view,
            as: .image,
            named: named,
            file: getFilePath(),
            testName: testName)
        XCTAssertNil(result)
    }

}





