//
//  ParagraphTest.swift
//  AdmiralUIKitTests
//
//  Created on 21.07.2022.
//

import XCTest
import SnapshotTesting
import AdmiralTheme
import AdmiralUIResources
@testable import AdmiralUIKit

class ParagraphTest: XCTestCase {
    
    private let titleLargeText = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
    
    override func setUp() {
        super.setUp()
        Appearance.prepare()
    }
    
    // MARK: - Theme
    
    private lazy var theme: AppTheme = {
        let theme = Appearance.shared.theme
        return theme
    }()
    
    // MARK: - Primary
    
    func testPrimaryParagraph() {
        let view = configureParagraph(paragraphStyle: .primary)
        checkView(view: view, named: "Primary", testName: "Paragraph")
    }
    
    func testPrimaryParagraphDark() {
        theme = .dark
        let view = configureParagraph(paragraphStyle: .primary)
        checkView(view: view, named: "Primary.Dark", testName: "Paragraph")
    }
    
    // MARK: - Secondary
    
    func testSecondaryParagraph() {
        let view = configureParagraph(paragraphStyle: .secondary)
        checkView(view: view, named: "Secondary", testName: "Paragraph")
    }
    
    func testSecondaryParagraphDark() {
        theme = .dark
        let view = configureParagraph(paragraphStyle: .secondary)
        checkView(view: view, named: "Secondary.Dark", testName: "Paragraph")
    }
    
    // MARK: - View
      
    private func configureParagraph(paragraphStyle: ParagraphStyle) -> Paragraph {
        let paragrap = Paragraph()
        paragrap.paragraphType = .point
        paragrap.paragraphStyle = paragraphStyle
        paragrap.title = titleLargeText
        paragrap.frame.size = CGSize(width: 320.0, height: 100.0)
        paragrap.apply(theme: theme)
        return paragrap
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
