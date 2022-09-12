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
    /// Set title font for label
    case title
    /// Set body font for label
    case body
    /// Set headline font for label
    case headline
    /// Set headlineSecondary font for label
    case headlineSecondary

    // MARK: - Computed Properties

    public var textBlockStyle: TextBlockStyle {
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
