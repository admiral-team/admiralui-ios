//
//  ButtonListView.swift
//  AdmiralSwiftUI
//
//  Created on 21.06.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources

/**
 ButtonListView - A view object with subtitle label and image view.
 
 You can create a ButtonListView with the zero frame rectangle by specifying the following parameters in init:
 - text: String - The text that the button label displays.
 - action: () -> () - The callback action by tapping the button
 
 ButtonListView has a public property:
 - isHighlighted: Bool - A Boolean value indicating whether the view is in the highlighted state.
 - isHighlightedEnabled: Bool - A Boolean value indicating whether the view can  draws a highlight.
 
 ## Example to create ButtonListView
 # Code
 ```
 ButtonListView(text: "Button", action: {}) 
```
 */
/// A view object with arrow image view.
@available(iOS 14.0, *)
public struct ButtonListView: View, TralingListViewComponent {
    
    // MARK: - Public Properties
    
    @State public var isHighlighted: Bool = false
    @State public var isHighlightedEnabled: Bool = true
    
    // MARK: Internal Properties
    
    @Binding var text: String
    var action: () -> ()
    
    @State private var scheme: ButtonListViewScheme? = nil
    @ObservedObject private var schemeProvider = SwiftUISchemeProvider<ButtonListViewScheme>()
    
    // MARK: - Initializer
    
    /// Initializes and returns a newly allocated view object with the zero frame rectangle.
    public init(text: String, action: @escaping () -> ()) {
        self._text = Binding(get: { return text }, set: { _ in })
        self.action = action
    }

    public var body: some View {
        HStack(alignment: .center) {
            Button(text, action: action)
                .buttonStyle(GhostButtonStyle())
        }
    }
    
}


