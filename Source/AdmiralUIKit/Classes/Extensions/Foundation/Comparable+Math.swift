//
//  Comparable+Math.swift
//  AdmiralUI
//
//  Created on 28.10.2020.
//

import Foundation


func limit<T>(_ value: T, min minValue: T, max maxValue: T) -> T where T: Comparable {
    if value < minValue {
        return minValue
    } else if value > maxValue {
        return maxValue
    } else {
        return value
    }
}
