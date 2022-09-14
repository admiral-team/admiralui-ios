//
//  HeaderStyle.swift
//  AdmiralSwiftUI
//
//  Created on 23.09.2021.
//

import SwiftUI
/**
 TextBlockStyle - Public enum for TextBlock AdmiralSwiftUI library

 TextBlockStyle can be one of the following values:
 - title
 - body
 - headline
 - headlineSecondary
 - paragraph
 - dropDown
 - paragraphSecondary
 - link
 - separator
 - separatorShort
 - separatorEmpty

 Also TextBlockStyle has properties responsible for margins and absolute values of the size grid
 - minHeight: CGFloat
 - edgeInsets: EdgeInsets
 */
@available(iOS 14.0, *)
public enum TextBlockStyle: String {
    case title
    case body
    case headline
    case headlineSecondary
    case dropDown
    case paragraph
    case paragraphSecondary
    case link
    case separator
    case separatorShort
    case separatorEmpty

    // MARK: - Computed Properties

    public var minHeight: CGFloat {
        switch self {
        case .title, .dropDown:
            return LayoutGrid.halfModule * 16
        case .body:
            return LayoutGrid.halfModule * 13
        case .headline, .headlineSecondary:
            return LayoutGrid.halfModule * 9
        case .paragraph, .paragraphSecondary, .link:
            return LayoutGrid.halfModule * 10
        case .separator, .separatorShort, .separatorEmpty:
            return LayoutGrid.doubleModule
        }
    }

    public var edgeInsets: EdgeInsets {
        switch self {
        case .title, .dropDown:
            return EdgeInsets(
                top: LayoutGrid.halfModule * 5,
                leading: LayoutGrid.doubleModule,
                bottom: LayoutGrid.halfModule * 4,
                trailing: LayoutGrid.doubleModule)
        case .body:
            return EdgeInsets(
                top: LayoutGrid.halfModule * 3,
                leading: LayoutGrid.doubleModule,
                bottom: LayoutGrid.halfModule * 3,
                trailing: LayoutGrid.doubleModule)
        case .headline, .headlineSecondary:
            return EdgeInsets(
                top: LayoutGrid.halfModule,
                leading: LayoutGrid.doubleModule,
                bottom: LayoutGrid.halfModule,
                trailing: LayoutGrid.doubleModule)
        case .paragraph, .paragraphSecondary, .link, .separatorShort, .separatorEmpty:
            return EdgeInsets(
                top: LayoutGrid.module,
                leading: LayoutGrid.doubleModule,
                bottom: LayoutGrid.module,
                trailing: LayoutGrid.doubleModule)
        case .separator:
            return EdgeInsets(
                top: LayoutGrid.module,
                leading: 0.0,
                bottom: LayoutGrid.module,
                trailing: 0.0)
        }
    }
}
