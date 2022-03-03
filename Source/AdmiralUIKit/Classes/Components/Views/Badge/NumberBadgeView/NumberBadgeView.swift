//
//  NumberBadge.swift
//  AdmiralUI
//
//  Created on 16.10.2020.
//

import UIKit

/// This is badge component in which you can set the value using a number, and you can also set the maximum number.
public class NumberBadge: Badge {
    
    // MARK: - Public Properties
    
    /// Integer value of the badge.
    public var value: Int = 1 {
        didSet { updateValue() }
    }
    
    /// Maximum integer value of the badge.
    public var maxValue: Int = .max {
        didSet { updateValue() }
    }
    
    // MARK: - Private Properties
    
    private func updateValue() {
        if value > maxValue {
            self.text = String(format: "%i+", maxValue)
        } else {
            self.text = String(value)
        }
    }
    
}
