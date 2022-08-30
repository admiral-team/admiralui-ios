//
//  ParagraphStyle.swift
//  AdmiralSwiftUI
//
//  Created on 27.09.2021.
//

/**
 ParagraphStyle - Public enum for paragraph text block style AdmiralSwiftUI library

 ParagraphStyle can be one of the following values:
 - primary
 - secondary
 */
@available(iOS 14.0, *)
public enum ParagraphStyle: String {
    /// The primary style of Paragraph
    case primary
    /// The secondary style of Paragraph
    case secondary

    // MARK: - Computed Properties

    var textBlockStyle: TextBlockStyle {
        switch self {
        case .primary:
            return .paragraph
        case .secondary:
            return .paragraphSecondary
        }
    }
}

