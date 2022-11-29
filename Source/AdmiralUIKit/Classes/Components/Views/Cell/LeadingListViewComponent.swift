//
//  CenterListViewComponent.swift
//  AdmiralUI
//
//  Created on 20.11.2020.
//

import UIKit

/// The protocol for image view list cell.
public protocol LeadingListViewComponent: UIView {
    
    /// A Boolean value indicating whether the view is in the enabled state.
    var isEnabled: Bool { get set }
    
    /// A Boolean value indicating whether the control draws a highlight.
    var isHighlighted: Bool { get set }
    
    /// A Boolean value indicating whether the view can  draws a highlight.
    var isHighlightedEnabled: Bool { get set }
}
