//
//  AFont.swift
//  AdmiralTheme
//
//  Created by on 26.09.2022.
//  
//
import SwiftUI
import UIKit
/**
 AFont - The general structure for storing font information in the UIKit and SwiftUI.

 You can create a AColor with the zero frame rectangle by specifying the following parameters in init:
 - name: String - The font name
 - family: String - The value that presents set of fonts that have a common design
 - size: CGFloat - The font size
 - weight: CGFloat - The value placed on your font that will determine how bold or light your text will appear
 - letterSpacing: CGFloat - The value that sets the horizontal spacing behavior between text characters
 - textStyle: UIFont.TextStyle? - The constants that describe the preferred styles for fonts
 ## Example to create AFont
 # Code
 let font = AFont(
  name: "SFProDisplay-Medium", family: "SF Pro Display", size: 22.0, weight: 500, letterSpacing: 0.0, textStyle: .title3
 )
 ```
 */
/// The container that store information about font.
public class AFont: Codable {

    // MARK: - Public Properties

    /// The font name
    public let name: String

    /// The value that presents set of fonts that have a common design
    public let family: String

    /// The font size
    public let size: CGFloat

    /// The value placed on your font that will determine how bold or light your text will appear
    public let weight: CGFloat

    /// The value that sets the horizontal spacing behavior between text characters
    public let letterSpacing: CGFloat

    /// The constants that describe the preferred styles for fonts.
    public let textStyle: UIFont.TextStyle?

    // MARK: - Computed Properties

    /// The value that generate UIFont
    public var uiFont: UIFont {
        if let font = UIFont(name: name, size: size) {
            return font
        } else {
            assert(true, "Font with name \"\(name)\" not found!")
            return UIFont.systemFont(ofSize: size)
        }
    }

    // MARK: - Initializer

    /// AppTheme Initializer.
    /// - Parameters:
    ///   - name: The font name
    ///   - family: The value that presents set of fonts that have a common design
    ///   - size: - The font size
    ///   - weight: - The value placed on your font that will determine how bold or light your text will appear
    ///   - letterSpacing:- The value that sets the horizontal spacing behavior between text characters
    ///   - textStyle: - The constants that describe the preferred styles for fonts
    public init(
        name: String,
        family: String,
        size: CGFloat,
        weight: CGFloat,
        letterSpacing: CGFloat,
        textStyle: UIFont.TextStyle?
    ) {
        self.name = name
        self.family = family
        self.size = size
        self.weight = weight
        self.letterSpacing = letterSpacing
        self.textStyle = textStyle
    }

}

// MARK: - Extensions

@available(iOS 13.0.0, *)
public extension AFont {

    var swiftUIFont: SwiftUI.Font {
        return SwiftUI.Font(self.uiFont)
    }

}

public extension UIFont {

    class func registerFontWithFilenameString(filenameString: String, bundle: Bundle) {
        guard let pathForResourceString = bundle.path(forResource: filenameString, ofType: nil) else {
            print("UIFont+:  Failed to register font - path for resource not found.")
            return
        }

        guard let fontData = NSData(contentsOfFile: pathForResourceString) else {
            print("UIFont+:  Failed to register font - font data could not be loaded.")
            return
        }

        guard let dataProvider = CGDataProvider(data: fontData) else {
            print("UIFont+:  Failed to register font - data provider could not be loaded.")
            return
        }

        guard let fontRef = CGFont(dataProvider) else {
            print("UIFont+:  Failed to register font - font could not be loaded.")
            return
        }

        var errorRef: Unmanaged<CFError>?
        if CTFontManagerRegisterGraphicsFont(fontRef, &errorRef) == false {
            print("UIFont+:  Failed to register font - register graphics font failed - this font may have already been registered in the main bundle.")
        }
    }

}
