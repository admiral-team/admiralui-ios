//
//  ListView.swift
//  AdmiralUI
//
//  Created on 30.11.2020.
//

import UIKit

/// A base class for list view.
open class BaseListView: UIView {

    // MARK: - Public Properties
    
    /// A Boolean value indicating whether the view is in the enabled state.
    public var isEnabled: Bool {
        get { !state.contains(.disabled) }
        set {
            if newValue {
                state.remove(.disabled)
            } else {
                state.insert(.disabled)
            }
        }
    }
    
    /// The style of selected list view.
    public var isHighlightedEnabled: Bool = true {
        didSet {
            if !isHighlightedEnabled { isHighlighted = false }
        }
    }
    
    /// A Boolean value indicating whether the view is in the highlighted state.
    public var isHighlighted: Bool {
        get { state.contains(.highlighted) }
        set {
            guard isHighlightedEnabled else {
                state.remove(.highlighted)
                return
            }
            
            if newValue {
                state.insert(.highlighted)
            } else {
                state.remove(.highlighted)
            }
        }
    }
    
    // MARK: - Internal Properties
    
    /// The state of the view. Default is normal.
    var state: UIControl.State = .normal
    
}
