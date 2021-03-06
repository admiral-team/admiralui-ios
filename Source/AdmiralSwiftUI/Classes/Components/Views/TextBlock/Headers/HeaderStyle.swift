//
//  HeaderStyle.swift
//  AdmiralSwiftUI
//
//  Created on 27.09.2021.
//

/**
 HeaderStyle - Public enum for Headers AdmiralSwiftUI library
 
 HeaderStyle can be one of the following values:
 - title
 - body
 - headline
 - headlineSecondary
 */
@available(iOS 14.0, *)
public enum HeaderStyle: String {
    case title
    case body
    case headline
    case headlineSecondary
    
    var textBlockStyle: TextBlockStyle {
        switch self {
        case .title:
            return .title
        case .body:
            return .body
        case .headline:
            return .headline
        case .headlineSecondary:
            return .headlineSecondary
        }
    }
}
