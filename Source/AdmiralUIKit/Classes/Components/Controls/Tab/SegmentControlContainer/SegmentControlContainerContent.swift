//
//  SegmentContainerContentControl.swift
//  AdmiralUI
//
//  Created on 11.11.2020.
//

import UIKit

/// Interface segment control.
public protocol SegmentControlContainerContent: UIControl {
    /// The index number identifying the selected segment (that is, the last segment touched).
    var selectedSegmentIndex: Int { get set }
    
    /// Returns the number of segments the receiver has.
    var numberOfSegments: Int { get }
}
