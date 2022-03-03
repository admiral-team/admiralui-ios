//
//  Optional.swift
//  AdmiralUI
//
//  Created on 13.10.2020.
//

import Foundation

infix operator !! : NilCoalescingPrecedence

/// Force-unwraps `value` with a custom error message.
/// - parameters:
///   - value: The value to be force-unwrapped.
///   - panic: The panic function to be called in case of failure.
/// - returns: The unwrapped value.
public func !! <Value>(_ value: Value?, _ panic: @autoclosure () -> Never) -> Value {
    guard let value = value else {
        panic()
    }
    
    return value
}
