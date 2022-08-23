//
//  ImageNameListView.swift
//  AdmiralSwiftUI
//
//  Created on 22.06.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources

/**
 ImageNameListView - A view object with card image view.
 
 You can create a ImageNameListView with the zero frame rectangle by specifying the following parameters in init:
 - text: String - The text displayed in the text label.

 ## Example to create ImageNameListView
 # Code
 ```
 ImageNameListView(text: "Text")
```
 */
/// A view object with background view and image view.
@available(iOS 14.0, *)
public struct ImageNameListView: View, ImageListViewComponent {

    // MARK: - Public Properties
    
    /// The text displayed in the text label.
    @Binding public var text: String
    
    @State public var isHighlighted: Bool = false
    @State public var isHighlightedEnabled: Bool = true
    
    // MARK: Internal Properties
    
    @Environment(\.isEnabled) var isEnabled
    @Environment(\.manager) var manager
    
    @Binding private var scheme: ImageNameListViewScheme?
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<ImageNameListViewScheme>()
    
    // MARK: - Initializer
    
    /// Initializes and returns a newly allocated view object with the zero frame rectangle.
    public init(
        text: String,
        scheme: Binding<ImageNameListViewScheme?> = .constant(nil)
    ) {
        self._text = Binding(get: { return text }, set: { _ in })
        self._scheme = scheme
    }

    // MARK: - Body

    public var body: some View {
        let scheme = self.scheme ?? schemeProvider.scheme
        Text(text)
            .foregroundColor(scheme.titleLabelTextColor.parameter(for: isEnabled ? .normal : .disabled)?.swiftUIColor)
            .font(scheme.titleFont.swiftUIFont)
            .frame(width: LayoutGrid.halfModule * 11, height: LayoutGrid.halfModule * 11)
            .background(scheme.backgroundNameViewColor.parameter(for: isEnabled ? .normal : .disabled)?.swiftUIColor)
            .cornerRadius((LayoutGrid.halfModule * 11) / 2)
    }
    
    // MARK: - Internal Methods
    
    func scheme(_ scheme: Binding<ImageNameListViewScheme?>) -> some View {
        var view = self
        view._scheme = scheme
        return view.id(UUID())
    }
    
}
