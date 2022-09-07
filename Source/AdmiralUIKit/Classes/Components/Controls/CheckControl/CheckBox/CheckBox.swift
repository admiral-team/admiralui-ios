//
//  CheckBox.swift
//  AdmiralUI
//
//  Created on 20.10.2020.
//

import UIKit
import AdmiralUIResources

/// Checkboxes is element a graphical user interface element allowing the user to control a parameter with two states - enabled and disabled.
public class CheckBox: CheckControl {
    
    // MARK: - Internal Methods
    
    override func commonInit() {
        super.commonInit()
        selectedImage = SystemAsset.Custom.Control.checkBoxOn.image
        defaultImage = SystemAsset.Custom.Control.checkBoxOff.image
        updateState()
    }
    
}
