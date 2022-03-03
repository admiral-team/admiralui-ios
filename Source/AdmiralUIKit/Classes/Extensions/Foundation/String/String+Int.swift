//
//  String+Int.swift
//  AdmiralUI
//
//  Created on 17.03.2021.
//

import Foundation

extension String {
    
    public func toInt() -> Int? {
        if let num = NumberFormatter().number(from: self) {
            return num.intValue
        } else {
            return nil
        }
    }
    
}
