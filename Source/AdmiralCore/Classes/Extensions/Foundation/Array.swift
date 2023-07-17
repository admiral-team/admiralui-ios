//
//  Array.swift
//  AdmiralSwiftUI
//
//  Created by on 12.04.2023.
//  
//


import Foundation

public extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: self.count, by: size).map {
            Array(self[$0..<Swift.min($0 + size, self.count)])
        }
    }
}
