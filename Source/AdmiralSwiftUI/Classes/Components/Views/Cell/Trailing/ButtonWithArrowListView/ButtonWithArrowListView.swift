//
//  ButtonWithArrowListView.swift
//  AdmiralSwiftUI
//
//  Created on 21.06.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources

/**
 ButtonWithArrowListView - A view object with subtitle label and image view.
 
 You can create a ButtonWithArrowListView with the zero frame rectangle by specifying the following parameters in init:
 - text: String - The text that the button label displays.
 - image: Image - The image that the button displays.
 - action: () -> () - The callback action by tapping the button
 
 ButtonWithArrowListView has a public property:
 - isHighlighted: Bool - A Boolean value indicating whether the view is in the highlighted state.
 - isHighlightedEnabled: Bool - A Boolean value indicating whether the view can  draws a highlight.
 
 ## Example to create ButtonWithArrowListView
 # Code
 ```
 ButtonWithArrowListView(
     text: "ButtonWithArrowListView",
     image: Image("Your image"),
     action: {})
```
 */
/// A view object with button and arrow image view.
@available(iOS 14.0, *)
public struct ButtonWithArrowListView: View, LeadingListViewComponent, TralingListViewComponent {
    
    // MARK: - Public Properties
    
    @State public var isHighlighted: Bool = false
    @State public var isHighlightedEnabled: Bool = true
    
    // MARK: Internal Properties
    
    @Binding var image: Image
    @Binding var text: String
    var action: () -> ()
    
    @State private var scheme: ButtonWithArrowListViewScheme? = nil
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<ButtonWithArrowListViewScheme>()
    
    // MARK: - Initializer
    
    /// Initializes and returns a newly allocated view object with the zero frame rectangle.
    public init(text: String, image: Image = Image(uiImage: PrivateAsset.Custom.Cell.arrowDown.image), action: @escaping () -> ()) {
        self._text = Binding(get: { return text }, set: { _ in })
        self._image = Binding(get: { return image }, set: { _ in })
        self.action = action
    }

    public var body: some View {
        let scheme = self.scheme ?? schemeProvider.scheme
        scheme.image = image
        return Button(text, action: action)
                .buttonStyle(scheme.button)
    }
    
}
