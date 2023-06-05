//
//  TextBlockHeaderTest.swift
//  AdmiralUIKitTests
//
//  Created on 24.02.2022.
//

import XCTest
import SnapshotTesting
import AdmiralTheme
@testable import AdmiralUIKit

class TextBlockHeaderTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        Appearance.prepare()
    }
    
    // MARK: - Theme
    
    private lazy var theme: AppTheme = {
        let theme = Appearance.shared.theme
        return theme
    }()
    
    func testTitleHeader() {
        let view = configureTitleHeader(headerStyle: .title)
        checkView(view: view, named: "Default.Title", testName: "TitleHeader")
    }
    
    func testDropDownHeader() {
        let view = configureDropDownHeader(headerStyle: .title)
        checkView(view: view, named: "Default.Title", testName: "DropDownHeader")
    }
    
    func testSubtitleTitleHeader() {
        let view = configureSubtitleTitleHeader(headerStyle: .title)
        checkView(view: view, named: "Default.Title", testName: "SubtitleTitleHeader")
    }
    
    func testTitleSubtitleHeader() {
        let view = configureTitleSubtitleHeader(headerStyle: .title)
        checkView(view: view, named: "Default.Title", testName: "TitleSubtitle")
    }
    
    func testArrowWithButtonHeader() {
        theme = .dark
        let view = configureArrowWithButtonHeader(headerStyle: .title)
        checkView(view: view, named: "Default.Title", testName: "ArrowWithButtonHeader")
    }
    
    func testTitleHeaderDark() {
        theme = .dark
        let view = configureTitleHeader(headerStyle: .title)
        checkView(view: view, named: "Default.Title.Dark", testName: "TitleHeader")
    }
    
    func testDropDownHeaderDark() {
        theme = .dark
        let view = configureDropDownHeader(headerStyle: .title)
        checkView(view: view, named: "Default.Title.Dark", testName: "DropDownHeader")
    }
    
    func testSubtitleTitleHeaderDark() {
        theme = .dark
        let view = configureSubtitleTitleHeader(headerStyle: .title)
        checkView(view: view, named: "Default.Title.Dark", testName: "SubtitleTitleHeader")
    }
    
    func testTitleSubtitleHeaderDark() {
        theme = .dark
        let view = configureTitleSubtitleHeader(headerStyle: .title)
        checkView(view: view, named: "Default.Title.Dark", testName: "TitleSubtitle")
    }
    
    func testArrowWithButtonHeaderDark() {
        theme = .dark
        let view = configureArrowWithButtonHeader(headerStyle: .title)
        checkView(view: view, named: "Default.Title.Dark", testName: "ArrowWithButtonHeader")
    }
    
    // MARK: - View
    
      
    private func configureTitleHeader(headerStyle: HeaderStyle) -> TitleHeader {
        let header = TitleHeader(title: "Title", textAligment: .left, headerStyle: headerStyle)
        header.frame.size = CGSize(width: 320.0, height: 80.0)
        header.apply(theme: theme)
        return header
    }
    
    private func configureDropDownHeader(headerStyle: HeaderStyle) -> DropDownHeader {
        let header = DropDownHeader(title: "Title", dropDownHeaderType: .down, headerStyle: headerStyle)
        header.frame.size = CGSize(width: 320.0, height: 80.0)
        header.apply(theme: theme)
        return header
    }
    
    private func configureSubtitleTitleHeader(headerStyle: HeaderStyle) -> SubtitleTitleHeader {
        let header = SubtitleTitleHeader(title: "Title", subtitle: "Subtitle", headerStyle: headerStyle)
        header.frame.size = CGSize(width: 320.0, height: 80.0)
        header.apply(theme: theme)
        return header
    }
    
    private func configureTitleSubtitleHeader(headerStyle: HeaderStyle) -> TitleSubtitleHeader {
        let header = TitleSubtitleHeader(title: "Title", subtitle: "Subtitle", headerStyle: headerStyle)
        header.frame.size = CGSize(width: 320.0, height: 80.0)
        header.apply(theme: theme)
        return header
    }
    
    private func configureArrowWithButtonHeader(headerStyle: HeaderStyle) -> TitleSubtitleHeader {
        let header = TitleSubtitleHeader(title: "Title", subtitle: "Subtitle", headerStyle: headerStyle)
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

