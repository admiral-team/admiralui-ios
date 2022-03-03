//
//  UIEdgeInsets+Operators.swift
//  AdmiralSwiftUI
//
//  Created on 24.12.2021.
//

import UIKit

public func + (left: UIEdgeInsets, right: UIEdgeInsets) -> UIEdgeInsets {

    return UIEdgeInsets(top: left.top + right.top,
                        left: left.left + right.left,
                        bottom: left.bottom + right.bottom,
                        right: left.right + right.right)

}

public func - (left: UIEdgeInsets, right: UIEdgeInsets) -> UIEdgeInsets {

    return UIEdgeInsets(top: left.top - right.top,
                        left: left.left - right.left,
                        bottom: left.bottom - right.bottom,
                        right: left.right - right.right)

}

