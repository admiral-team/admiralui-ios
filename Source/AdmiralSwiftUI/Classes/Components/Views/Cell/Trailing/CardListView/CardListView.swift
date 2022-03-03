//
//  CardListView.swift
//  AdmiralSwiftUI
//
//  Created on 21.06.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources

/**
 IconListView - A view object with card image view.
 
 You can create a IconListView with the zero frame rectangle by specifying the following parameters in init:
 - image: Image - The image displayed in the image view.
 - renderingMode: Image.TemplateRenderingMode - The Image template rendering mod. Default state is .original
 
 IconListView has a public property:
 - isHighlighted: Bool - A Boolean value indicating whether the view is in the highlighted state.
 - isHighlightedEnabled: Bool - A Boolean value indicating whether the view can  draws a highlight.
 
 ## Example to create IconListView
 # Code
 ```
 IconListView(image: Image("Your image"))
```
 */
/// A view object with card image view.
@available(iOS 14.0, *)
public struct CardListView: View, TralingListViewComponent {

    // MARK: - Public Properties
    
    /// The card image displayed in the image view.
    @Binding public var image: Image
    
    @State public var isHighlighted: Bool = false
    @State public var isHighlightedEnabled: Bool = true
    
    // MARK: Internal Properties
    
    @Environment(\.isEnabled) var isEnabled
    
    var renderingMode: Image.TemplateRenderingMode
    @State private var scheme: CardListViewScheme? = nil
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<CardListViewScheme>()
    
    // MARK: - Initializer
    
    /// Initializes and returns a newly allocated view object with the zero frame rectangle.
    public init(image: Image, renderingMode: Image.TemplateRenderingMode = .original) {
        self._image = Binding(get: { return image }, set: { _ in })
        self.renderingMode = renderingMode
    }

    public var body: some View {
        let scheme = self.scheme ?? schemeProvider.scheme
        switch renderingMode {
        case .original:
            image
                .frame(width: LayoutGrid.halfModule * 10, height: LayoutGrid.quadrupleModule)
                .opacity(scheme.imageViewAlpha.parameter(for: isEnabled ? .normal : .disabled) ?? 1.0)
        case .template:
            image
                .frame(width: LayoutGrid.halfModule * 10, height: LayoutGrid.quadrupleModule)
                .foregroundColor(scheme.imageTintColor.parameter(for: isEnabled ? .normal : .disabled)?.swiftUIColor)
        @unknown default:
            Spacer()
        }
    }
    
}



