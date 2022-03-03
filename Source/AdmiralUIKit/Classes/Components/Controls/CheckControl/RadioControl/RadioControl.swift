//
//  RadioControl.swift
//  AdmiralUI
//
//  Created on 21.10.2020.
//

import UIKit
import AdmiralUIResources

/// Radio control is an interface element that allows the user to select one option (item) from a predefined set (group).
public class RadioControl: CheckControl {

    // MARK: - Internal Methods
    
    override func commonInit() {
        super.commonInit()
        selectedImage = PrivateAsset.Custom.Control.radioButtonOn.image
        defaultImage = PrivateAsset.Custom.Control.radioButtonOff.image
        updateState()
    }
    
}
