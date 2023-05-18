//
//  CheckBox.swift
//  AdmiralUI
//
//  Created on 20.10.2020.
//

import UIKit

/**
 CheckBox is element a graphical user interface element allowing the user to control a parameter with two states - enabled and disabled.
 
 The Checkboxes has some internal properties for customizing the element:
 
 Internal Properties:
 - checkState: CheckControlState - State control.
 - isSelected: Bool - A Boolean value indicating whether the control is in the selected state.
 - isEnabled: Bool - A Boolean value indicating whether the control is in the enabled state.
 - isHighlighted: Bool - A Boolean value indicating whether the control is in the highlighted state.
 
 Example for create CheckBox:
 
 Code
 ```
 let checkBox = CheckBox()
 checkBox.isSelected = true
 ```
*/

public class CheckBox: CheckControl {
    
    // MARK: - Internal Methods
    
    override func commonInit() {
        super.commonInit()
        selectedImage = Asset.System.Solid.checkBoxOn.image
        defaultImage = Asset.System.Outline.checkBoxOff.image
        updateState()
    }
    
}
