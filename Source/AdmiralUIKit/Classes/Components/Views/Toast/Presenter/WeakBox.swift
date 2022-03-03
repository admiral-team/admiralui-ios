//
//  WeakBox.swift
//  AdmiralSwiftUI
//
//  Created on 24.12.2021.
//

import Foundation

/// Class to encapsulate weak reference to object.
class WeakBox<T: AnyObject> {
    
    /// Weak reference to object.
    weak var value: T?
    
    /// Initializer
    ///
    /// - Parameter value: Weak reference to object.
    init(value: T?) {
        self.value = value
    }
    
}
