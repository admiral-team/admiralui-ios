//
//  String+Regex.swift
//  ExampleiOS
//
//  Created on 18.02.2021.
//

import Foundation

extension String {
    
    func matches(_ regex: String) -> Bool {
        self.range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
    }
    
}
