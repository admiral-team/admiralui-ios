//
//  HeaderStyle.swift
//  AdmiralUIResources
//
//  Created on 21.02.2022.
//

import UIKit

/**
 HeaderStyle - Public enum for Headers AdmiralSwiftUI library
 
 HeaderStyle can be one of the following values:
 - title
 - body
 - headline
 - headlineSecondary
 */
public enum HeaderStyle: String {
    case title
    case body
    case headline
    case headlineSecondary
    case link
    
    var height: CGFloat {
        switch self {
        case .title:
            return LayoutGrid.module * 8
        case .body:
            return LayoutGrid.halfModule * 13
        case .headline:
            return LayoutGrid.halfModule * 9
        case .headlineSecondary:
            return LayoutGrid.halfModule * 9
        case .link:
            return LayoutGrid.halfModule * 10
        }
    }
    
    var edgeInsets: UIEdgeInsets {
        switch self {
        case .title:
            return UIEdgeInsets(
                top: LayoutGrid.halfModule * 5,
                left: LayoutGrid.doubleModule,
                bottom: LayoutGrid.halfModule * 4,
                right: LayoutGrid.doubleModule)
        case .body:
            return UIEdgeInsets(
                top: LayoutGrid.halfModule * 3,
                left: LayoutGrid.doubleModule,
                bottom: LayoutGrid.halfModule * 3,
                right: LayoutGrid.doubleModule)
        case .headline, .headlineSecondary:
            return UIEdgeInsets(
                top: LayoutGrid.halfModule,
                left: LayoutGrid.doubleModule,
                bottom: LayoutGrid.halfModule,
                right: LayoutGrid.doubleModule)
        case .link:
            return UIEdgeInsets(
                top: LayoutGrid.module,
                left: LayoutGrid.doubleModule,
                bottom: LayoutGrid.module,
                right: LayoutGrid.doubleModule)
        }
    }
}
