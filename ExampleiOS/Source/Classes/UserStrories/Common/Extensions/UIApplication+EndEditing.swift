//
//  UIApplication+EndEditing.swift
//  ExampleiOS
//
//  Created on 27.10.2021.
//

import SwiftUI

extension UIApplication {
    
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
}
