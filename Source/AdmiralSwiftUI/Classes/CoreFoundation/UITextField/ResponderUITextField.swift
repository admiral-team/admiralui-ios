//
//  CocoaTextField.swift
//  AdmiralSwiftUI
//
//  Created on 17.12.2021.
//

import UIKit
import SwiftUI

@available(iOS 14.0.0, *)
final class ResponderUITextField: UITextField {
    
    var isFirstResponderBinding: Binding<Bool>?

    var onDeleteBackward: () -> Void = { }
    
    var canPerformActionPaste: Bool = true
        
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @discardableResult
    override func becomeFirstResponder() -> Bool {
        defer {
            if isFirstResponderBinding?.wrappedValue != isFirstResponder {
                isFirstResponderBinding?.wrappedValue = isFirstResponder
            }
        }

        return super.becomeFirstResponder()
    }
    
    @discardableResult
    override func resignFirstResponder() -> Bool {
        defer {
            if isFirstResponderBinding?.wrappedValue != isFirstResponder {
                isFirstResponderBinding?.wrappedValue = isFirstResponder
            }
        }
        
       return super.resignFirstResponder()
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if !canPerformActionPaste {
            if action == #selector(UIResponderStandardEditActions.paste(_:)) {
                return false
            }
        }
        return super.canPerformAction(action, withSender: sender)
    }
    
    override func deleteBackward() {
        super.deleteBackward()
        
        onDeleteBackward()
    }
}
