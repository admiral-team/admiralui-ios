//
//  TextBlockDropDownTest.swift
//  AdmiralUIKitTests
//
//  Created on 24.02.2022.
//

import XCTest
import SnapshotTesting
import AdmiralTheme
import AdmiralUIResources
@testable import AdmiralUIKit

class TextBlockDropDownTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        Appearance.prepare()
    }
    
    // MARK: - Theme
    
    private lazy var theme: AppTheme = {
        let theme = Appearance.shared.theme
        return theme
    }()
    
    func testTitleButtonDropDownHeader() {
        let view = configureTitleButtonDropDownHeader()
        checkView(view: view, named: "Default", testName: "TitleButtonDropDown")
    }
    
    func testTitleButtonDropDownDark() {
        theme = .dark
        
        let view = configureTitleButtonDropDownHeader()
        checkView(view: view, named: "Default.Dark", testName: "TitleButtonDropDown")
    }
    
    func testButtonDropDown() {
        let view = configureButtonDropDown()
        checkView(view: view, named: "Default", testName: "ButtonDropDown")
    }
    
    func testButtonDropDownDark() {
        theme = .dark
        
        let view = configureButtonDropDown()
        checkView(view: view, named: "Default.Dark", testName: "ButtonDropDown")
    }
    
    // MARK: - View
    
      
    private func configureTitleButtonDropDownHeader() -> TitleButtonDropDown {
        let header = TitleButtonDropDown(title: "Title", buttonTitle: "Button", dropDownHeaderType: .down)
        header.frame.size = CGSize(width: 320.0, height: 80.0)
        header.apply(theme: theme)
        return header
    }
    
    private func configureButtonDropDown() -> ButtonDropDown {
        let header = ButtonDropDown(buttonTitle: "Button", dropDownHeaderType: .down)
        header.frame.size = CGSize(width: 320.0, height: 80.0)
        header.apply(theme: theme)
        return header
    }
    
    // MARK: - Private Methods
    
    
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
