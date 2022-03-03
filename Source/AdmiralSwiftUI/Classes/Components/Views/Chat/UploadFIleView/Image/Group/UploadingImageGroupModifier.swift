//
//  UploadingImageGroupModifier.swift
//  AdmiralSwiftUI
//
//  Created on 10.11.2021.
//

import SwiftUI

@available(iOS 14.0.0, *)
public struct UploadImageViewModifier: ViewModifier {

    private enum Constants {
        static let width: CGFloat = 234
        static let height: CGFloat = 114
        static let cornerRadius: CGFloat = LayoutGrid.module + 4
    }

    // MARK: - Private properties

    private let cornerStyle: UploadImageViewCornerStyle

    // MARK: - Computed Properties

    private var rectCorners: UIRectCorner {
        switch cornerStyle {
        case .leftSide:
            return [.topLeft, .bottomLeft]
        case .rightSide:
            return [.topRight, .bottomRight]
        case .allSides:
            return [.bottomRight, .topRight, .topLeft, .bottomLeft]
        case .top:
            return [.topRight, .topLeft]
        case .bottom:
            return [.bottomLeft, .bottomRight]
        case .bottomLeft:
            return [.bottomLeft]
        case .bottomRight:
            return [.bottomRight]
        case .topLeft:
            return [.topLeft]
        case .topRight:
            return [.topRight]
        case .none:
            return []
        }
    }

    private var frameSize: (CGFloat, CGFloat) {
        switch cornerStyle {
        case .leftSide, .rightSide, .bottomLeft, .bottomRight, .topLeft, .topRight, .bottom, .none:
            return (Constants.height, Constants.height)
        case .allSides, .top:
            return (Constants.width, Constants.height)
        }
    }

    // MARK: - Init/deinit

    init(cornerStyle: UploadImageViewCornerStyle = .allSides) {
        self.cornerStyle = cornerStyle
    }

    // MARK: - Layout

    public func body(content: Content) -> some View {
        content
            .frame(width: frameSize.0, height: frameSize.1)
            .clipShape(RoundedCorner(radius: Constants.cornerRadius, corners: rectCorners))
     }
}
