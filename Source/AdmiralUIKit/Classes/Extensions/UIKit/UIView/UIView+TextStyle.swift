//
//  UIView+TextStyle.swift
//  AdmiralUIResources
//
//  Created on 15.04.2021.
//

import UIKit

public extension UITextView {
    
    func setDynamicFont(
        font: UIFont,
        textStyle: UIFont.TextStyle?,
        maxFontScaleDelta: CGFloat = 3.0,
        adjustsFontForContentSize: Bool = true) {
        if
            let textStyle = textStyle,
            adjustsFontForContentSize,
            #available(iOS 11.0, *) {
            adjustsFontForContentSizeCategory = true
            let font = UIFontMetrics(forTextStyle: textStyle).scaledFont(
                for: font,
                maximumPointSize: font.pointSize + maxFontScaleDelta)
            self.font = font
        } else {
            self.font = font
        }
    }
    
}

public extension UITextField {
    
    func setDynamicFont(
        font: UIFont,
        textStyle: UIFont.TextStyle?,
        maxFontScaleDelta: CGFloat = 3.0,
        adjustsFontForContentSize: Bool = true
        ) {
        if
            let textStyle = textStyle,
            adjustsFontForContentSize,
            #available(iOS 11.0, *) {
            adjustsFontForContentSizeCategory = true
            let font = UIFontMetrics(forTextStyle: textStyle).scaledFont(
                for: font,
                maximumPointSize: font.pointSize + maxFontScaleDelta)
            self.font = font
        } else {
            self.font = font
        }
    }
    
}

public extension UILabel {
    
    func setDynamicFont(
        font: UIFont,
        textStyle: UIFont.TextStyle?,
        maxFontScaleDelta: CGFloat = 3.0,
        adjustsFontForContentSize: Bool = true) {
        if
            let textStyle = textStyle,
            adjustsFontForContentSize,
            #available(iOS 11.0, *) {
            adjustsFontForContentSizeCategory = true
            let font = UIFontMetrics(forTextStyle: textStyle).scaledFont(
                for: font,
                maximumPointSize: font.pointSize + maxFontScaleDelta)
            self.font = font
        } else {
            self.font = font
        }
    }
    
}

public protocol AccessibilitySupport {
    var adjustsFontForContentSizeCategory: Bool { get set }
}

public extension AccessibilitySupport {
    
}
