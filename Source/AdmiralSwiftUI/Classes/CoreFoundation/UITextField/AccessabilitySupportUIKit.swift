//
//  AccessabilitySupportUIKit.swift
//  AdmiralSwiftUI
//
//  Created on 17.09.2021.
//

import SwiftUI

@available(iOS 14.0, *)
public protocol AccessabilitySupportUIKit: View {
    
    /// For set accebility indificator UIKit Views.
    /// - Parameter identifierUIKit: Accessibility Indificator
    func accessibility(identifierUIKit: String) -> Self
}
