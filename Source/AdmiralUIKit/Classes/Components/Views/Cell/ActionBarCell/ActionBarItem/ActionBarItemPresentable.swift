//
//  ActionBarItemRepresentable.swift
//  AdmiralUIKit
//
//  Created on 07.02.2022.
//

import UIKit

protocol ActionBarViewPresentable: UIView {
    var tralingConstraint: NSLayoutConstraint? { get set }
    var isEnabled: Bool { get set }
}
