//
//  RoundedCorner.swift
//  AdmiralSwiftUI
//
//  Created on 07.06.2021.
//

import SwiftUI

@available(iOS 14.0.0, *)
struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
