//
//  TextBlockHeaderLinkTest.swift
//  AdmiralUIKitTests
//
//  Created on 24.02.2022.
//

import XCTest
import SnapshotTesting
import AdmiralCore
import AdmiralTheme
import AdmiralUIResources
@testable import AdmiralUIKit

class TextBlockHeaderLinkTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        Appearance.prepare()
    }
    
    // MARK: - Theme
    
    private lazy var theme: AppTheme = {
        let theme = Appearance.shared.theme
        return theme
    }()
    
    func testDropDownHeader() {
        let view = configureDropDownHeader()
        checkView(view: view, named: "Default", testName: "LinkViewHeader")
    }
    
    func testLinkViewHeaderDark() {
        theme = .dark
        
        let view = configureDropDownHeader()
        checkView(view: view, named: "Default.Dark", testName: "LinkViewHeader")
    }
    
    // MARK: - View
    
      
    private func configureDropDownHeader() -> DropDownHeader {
        let header = DropDownHeader(title: "Title", dropDownHeaderType: .down, headerStyle: .title)
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
