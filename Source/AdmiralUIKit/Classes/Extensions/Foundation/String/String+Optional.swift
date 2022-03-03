//
//  String+Optional.swift
//  AdmiralUI
//
//  Created on 19.10.2020.
//

import Foundation

public extension String {
    
    /// Return nil if string is empty.
    var nilIfEmpty: String? {
        return isEmpty ? nil : self
    }
    
}
