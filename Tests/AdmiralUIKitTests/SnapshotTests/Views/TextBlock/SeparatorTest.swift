//
//  SeparatorTest.swift
//  AdmiralUIKitTests
//
//  Created on 13.07.2022.
//

import XCTest
import SnapshotTesting
import AdmiralCore
import AdmiralTheme
import AdmiralUIResources
@testable import AdmiralUIKit

class SeparatorTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        Appearance.prepare()
    }
    
    // MARK: - Theme
    
    private lazy var theme: AppTheme = {
        let theme = Appearance.shared.theme
        return theme
    }()
    
    // MARK: - Long
    
    func testLongSeparator() {
        let view = configureSeparator(.long)
        checkView(view: view, named: "Long", testName: "Separator")
    }
    
    func testLongSeparatorDark() {
        theme = .dark
        
        let view = configureSeparator(.long)
        checkView(view: view, named: "Long.Dark", testName: "Separator")
    }
    
    // MARK: - Short
    
    func testShortSeparator() {
        let view = configureSeparator(.short)
        checkView(view: view, named: "Short", testName: "Separator")
    }
    
    func testShortSeparatorDark() {
        theme = .dark
        
        let view = configureSeparator(.short)
        checkView(view: view, named: "Short.Dark", testName: "Separator")
    }
    
    // MARK: - Empty
    
    func testEmptySeparator() {
        let view = configureSeparator(.empty)
        checkView(view: view, named: "Empty", testName: "Separator")
    }
    
    func testEmptySeparatorDark() {
        theme = .dark
        
        let view = configureSeparator(.empty)
        checkView(view: view, named: "Empty.Dark", testName: "Separator")
    }
    
    // MARK: - View
      
    private func configureSeparator(_ style: SeparatorStyle) -> Separator {
        let separator = Separator(separatorStyle: style)
        separator.frame.size = CGSize(width: 320.0, height: 30.0)
        separator.apply(theme: theme)
        return separator
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
