//
//  ListCellEmpty.swift
//  AdmiralSwiftUI
//
//  Created on 07.06.2021.
//

import SwiftUI
import AdmiralTheme

/**
 ListCellEmpty - A view object for sign empty list view.
 
 ListCellEmpty has empty init and three public properties:

 - isEnabled: Bool = false - A Boolean value indicating whether the view will be enable
 - isHighlighted: Bool = false - A Boolean value indicating whether the control draws a highlight.
 - isHighlightedEnabled: Bool = false - A Boolean value indicating whether the view can draws a highlight.
 */
/// A view object for sign empty list view.
@available(iOS 14.0.0, *)
public struct ListCellEmpty: View,
                             CenterListViewComponent,
                             TralingListViewComponent,
                             LeadingListViewComponent {
    
    public var isEnabled: Bool = false
    
    public var isHighlighted: Bool = false
    
    public var isHighlightedEnabled: Bool = false
    
    public var body: some View {
        return EmptyView()
    }
    
}

