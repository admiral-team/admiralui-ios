//
//  ColorToken.swift
//  ExampleiOS
//
//  Created on 17.02.2021.
//

import AdmiralUIKit
import UIKit

struct ColorToken {
    let hex: String
    let color: UIColor
    let name: String
    
    init(color: UIColor, name: String) {
        self.color = color
        self.name = name
        self.hex = color.hexString
    }
}
