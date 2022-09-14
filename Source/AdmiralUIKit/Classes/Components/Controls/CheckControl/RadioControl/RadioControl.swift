//
//  RadioControl.swift
//  AdmiralUI
//
//  Created on 21.10.2020.
//

import UIKit
import AdmiralUIResources

/**
 RadioControl is an interface element that allows the user to select one option (item) from a predefined set (group).
 
 The RadioControl has some internal properties for customizing the element:
 
 Internal Properties:
 - checkState: CheckControlState - State control.
 - isSelected: Bool - A Boolean value indicating whether the control is in the selected state.
 - isEnabled: Bool - A Boolean value indicating whether the control is in the enabled state.
 - isHighlighted: Bool - A Boolean value indicating whether the control is in the highlighted state.
 
 Example for create RadioControl
 
 Code
 ```
 let checkBox = RadioControl()
 checkBox.isSelected = true
 ```
*/

public class RadioControl: CheckControl {

    // MARK: - Internal Methods
    
    override func commonInit() {
        super.commonInit()
        selectedImage = SystemAsset.Custom.Control.radioButtonOn.image
        defaultImage = SystemAsset.Custom.Control.radioButtonOff.image
        updateState()
    }
    
}
