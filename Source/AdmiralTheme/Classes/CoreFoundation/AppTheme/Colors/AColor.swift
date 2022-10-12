//
//  AColor.swift
//  AdmiralTheme
//
//  Created by on 26.09.2022.
//  
//
import SwiftUI
import UIKit
/**
 AColor - The general structure for storing color information in the UIKit and SwiftUI.
 You can create a AColor with the zero frame rectangle by specifying the following parameters in init:
 - let red: CGFloat - The code level of red from 0.0 to 255.0
 - let green: CGFloat - The code level of green from 0.0 to 255.0
 - let blue: CGFloat - The code level of blue from 0.0 to 255.0
 - let alpha: CGFloat - The value specifies the opacity for a color
 - hexString: String -  The hexadecimal values of color
 ## Example to create CurrencyView
 # Code
 let color = AColor(red: 255, green: 255, blue: 255)
 ```
 */
/// The container that store information about color.
public struct AColor: Codable {

    // MARK: - Public Properties

    /// The code level of red from 0.0 to 255.0
    public let red: CGFloat

    /// The code level of green from 0.0 to 255.0
    public let green: CGFloat

    /// The code level of blue from 0.0 to 255.0
    public let blue: CGFloat

    /// The value specifies the opacity for a color
    public let alpha: CGFloat

    // MARK: - Computed Propertids

    public var uiColor: UIColor {
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }

    public var cgColor: CGColor {
        return uiColor.cgColor
    }

    public static var clear: AColor {
        return AColor(red: 0, green: 0, blue: 0, alpha: 0.0)
    }

    // MARK: - Initializer

    /// AColor Initializer.
    /// - Parameters:
    ///   - red: The red value
    ///   - green: The green value
    ///   - blue: The blue value
    ///   - alpha: The opacity for a color
    public init(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        self.red = red
        self.green = green
        self.blue = blue
        self.alpha = alpha
    }

    /// AColor Initializer.
    /// - Parameters:
    ///   - red: The red value
    ///   - green: The green value
    ///   - blue: The blue value
    public init(red: Int, green: Int, blue: Int) {
        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: 1.0
        )
    }

    /// AColor Initializer.
    /// - Parameters:
    ///   - hexString: The hexadecimal values of color
    public init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }

        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }

    /// AColor Initializer.
    /// - Parameters:
    ///   - color: The UIColor
    public init(color: UIColor) {
        let colorTo = CGColorSpace(name: CGColorSpace.sRGB)!
        let cgColorInRGB = color.cgColor.converted(
            to: colorTo,
            intent: .defaultIntent,
            options: nil)!

        let colorRef = cgColorInRGB.components
        let red = colorRef?[0] ?? 0
        let green = colorRef?[1] ?? 0
        let blue = ((colorRef?.count ?? 0) > 2 ? colorRef?[2] : green) ?? 0
        let alpha = color.cgColor.alpha
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }

    /// AppTheme Initializer.
    /// - Parameters:
    ///   - withAplha: The flag that sets color with opacity or not
    public func hexString(withAplha: Bool = true) -> String {
        var colorString = withAplha ? String(format: "#%02lX", lroundf(Float(alpha * 255))) : "#"

        colorString += String(
            format: "%02lX%02lX%02lX",
            lroundf(Float(red * 255)),
            lroundf(Float(green * 255)),
            lroundf(Float(blue * 255))
        )

        return colorString
    }

    /// Public method.
    /// - Parameters:
    ///   - withAlpha: The value of opactity
    public func withAlpha(_ alpha: CGFloat) -> AColor {
        return AColor(red: red, green: green, blue: blue, alpha: alpha)
    }

}

// MARK: - Extensions

@available(iOS 13.0.0, *)
public extension AColor {

    var swiftUIColor: SwiftUI.Color {
        return SwiftUI.Color(.sRGB, red: Double(red), green: Double(green), blue: Double(blue), opacity: Double(alpha))
    }

}

public extension UIColor {

    var color: AColor {
        return AColor(color: self)
    }

}
