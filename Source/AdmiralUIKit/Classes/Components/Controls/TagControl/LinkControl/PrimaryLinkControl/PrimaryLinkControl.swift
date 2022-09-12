//
//  PrimaryLinkControl.swift
//  AdmiralUI
//
//  Created on 19.10.2020.
//

import UIKit
import AdmiralTheme

/**
 PrimaryLinkControl - The primary link component сan be used to show hyperlinks in user interface.
 
 Internal Properties:
 - fontStyle: FontStyle - Type font label. Default is body.
 - leadingImage: UIImage? - Leading picture from text.
 - trailingImage: UIImage? - Trailing picture from text.
 
 Example to create PrimaryLinkControl:
 
 Code
 ```
 let linkControl = PrimaryLinkControl()
 
 private func setUpLinkControl() {
     linkControl.title = linkText
     linkControl.fontStyle = .body
     linkControl.style = .none
     linkControl.addTarget(self, action: #selector(tapLink), for: .touchUpInside)
 }
 ```
*/
open class PrimaryLinkControl: BaseLinkControl {
    
    // MARK: - Internal methods
    
    override func commonInit() {
        super.commonInit()
        apply(theme: defaultTheme)
    }
        
    // MARK: - Public methods
    
    open override func apply(theme: AppTheme) {
        super.apply(theme: theme)
        
        update(fontStyle: fontStyle)
    }
}
