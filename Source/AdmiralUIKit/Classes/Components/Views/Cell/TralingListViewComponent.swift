//
//  TralingListViewComponent.swift
//  AdmiralUI
//
//  Created on 17.11.2020.
//

import UIKit

/// The protocol for right view list cell.
public protocol TralingListViewComponent: UIView {
    
    /// A Boolean value indicating whether the view is in the enabled state.
    var isEnabled: Bool { get set }
    
    /// A Boolean value indicating whether the control draws a highlight.
    var isHighlighted: Bool { get set }
    
    /// A Boolean value indicating whether the view can  draws a highlight.
    var isHighlightedEnabled: Bool { get set }
}
