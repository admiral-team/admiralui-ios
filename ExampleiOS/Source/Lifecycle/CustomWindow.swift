//
//  CustomWindow.swift
//  ExampleiOS
//
//  Created on 12.01.2022.
//

import UIKit

class CustomWindow: UIWindow {
    
    weak var delegate: CustomWindowDelegate?
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if #available(iOS 12.0, *) {
            delegate?.userInterfaceStyleDidChange(self)
        }
    }
    
}
