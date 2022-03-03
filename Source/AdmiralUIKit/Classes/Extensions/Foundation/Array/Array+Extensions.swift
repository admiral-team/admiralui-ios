//
//  Array+Extensions.swift
//  AdmiralUIKit
//
//  Created on 25.01.2022.
//

import Foundation

public extension Array {

    func chunks(_ chunkSize: Int) -> [[Element]] {
        stride(from: 0, to:count, by: chunkSize).map {
            Array(self[$0..<Swift.min($0 + chunkSize, count)])
        }
    }

}
