//
//  UIColor+Support.swift
//  AdmiralUI
//
//  Created on 12.10.2020.
//

import UIKit

public extension UIColor {

    var hexString: String {
        guard
            let colorTo = CGColorSpace(name: CGColorSpace.sRGB),
            let cgColorInRGB = cgColor.converted(
                to: colorTo,
                intent: .defaultIntent,
                options: nil)
        else {
            return ""
        }
        
        let colorRef = cgColorInRGB.components
        let r = colorRef?[0] ?? 0
        let g = colorRef?[1] ?? 0
        let b = ((colorRef?.count ?? 0) > 2 ? colorRef?[2] : g) ?? 0
        let a = cgColor.alpha

        var color = String(
            format: "#%02lX%02lX%02lX",
            lroundf(Float(r * 255)),
            lroundf(Float(g * 255)),
            lroundf(Float(b * 255))
        )

        if a < 1 {
            color += String(format: "%02lX", lroundf(Float(a * 255)))
        }

        return color
    }
    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0,
                  green: CGFloat(green) / 255.0,
                  blue: CGFloat(blue) / 255.0,
                  alpha: 1.0)
    }
    
    convenience init(netHex: Int) {
        self.init(red: (netHex >> 16) & 0xff,
                  green: (netHex >> 8) & 0xff,
                  blue: netHex & 0xff)
    }
    
    convenience init(hexString: String) {
        let hexString = hexString.replacingOccurrences(of: "#", with: "")
        self.init(netHex: Int(strtoul(hexString, nil, 16)))
    }

}
