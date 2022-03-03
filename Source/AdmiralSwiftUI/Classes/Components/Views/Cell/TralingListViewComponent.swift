//
//  TralingListViewComponent.swift
//  AdmiralSwiftUI
//
//  Created on 07.06.2021.
//

import SwiftUI

/**
 TralingListViewComponent - The protocol for right view list cell.
 
 Public protocol properties:

 - isHighlighted: Bool { get set } - A Boolean value indicating whether the control draws a highlight.
 - isHighlightedEnabled: Bool { get set } - A Boolean value indicating whether the view can draws a highlight.
 */
/// The protocol for right view list cell.
@available(iOS 14.0.0, *)
public protocol TralingListViewComponent: View {
    
    /// A Boolean value indicating whether the control draws a highlight.
    var isHighlighted: Bool { get set }
    
    /// A Boolean value indicating whether the view can  draws a highlight.
    var isHighlightedEnabled: Bool { get set }
}
