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
public struct ButtonWithArrowListView: View, CenterListViewComponent, TralingListViewComponent {
    
    // MARK: - Public Properties
    
    @State public var isHighlighted: Bool = false
    @State public var isHighlightedEnabled: Bool = true
    
    // MARK: Internal Properties
    
    @Binding var image: Image
    @Binding var text: String
    var action: () -> ()

    // MARK: - Private Properties

    @ObservedObject private var schemeProvider: SchemeProvider<ButtonWithArrowListViewScheme>
    
    // MARK: - Initializer
    
    /// Initializes and returns a newly allocated view object with the zero frame rectangle.
    public init(
        text: String,
        image: Image = Image(uiImage: Asset.System.Outline.chevronDownOutline.image),
        schemeProvider: SchemeProvider<ButtonWithArrowListViewScheme> = AppThemeSchemeProvider<ButtonWithArrowListViewScheme>(),
        action: @escaping () -> ()
    ) {
        self._text = Binding(get: { return text }, set: { _ in })
        self._image = Binding(get: { return image }, set: { _ in })
        self.action = action
        self.schemeProvider = schemeProvider
    }

    // MARK: - Body

    public var body: some View {
        let scheme = schemeProvider.scheme
        Button(text, action: action)
            .buttonStyle(
                GhostButtonWithImageStyle(
                    image: image,
                    schemeProvider: .constant(scheme: scheme.button)
                )
            )
    }

}
