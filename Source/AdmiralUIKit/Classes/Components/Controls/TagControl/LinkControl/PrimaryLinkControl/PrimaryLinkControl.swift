//
//  PrimaryLinkControl.swift
//  AdmiralUI
//
//  Created on 19.10.2020.
//

import UIKit
import AdmiralTheme

/// The primary link component сan be used to show hyperlinks in user interface.
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
