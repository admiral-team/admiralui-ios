//
//  ImageCardListView.swift
//  AdmiralUIResources
//
//  Created on 22.06.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources

/**
 ImageCardListView - A view object with card image view.
 
 You can create a ImageCardListView with the zero frame rectangle by specifying the following parameters in init:

 - cardImage: Image - image for ImageCardListView

 ## Example to create ImageCardListView
 # Code
 ```
 ImageCardListView(
            cardImage: Image("Your image"))
```
 */
/// A view object with card image view.
@available(iOS 14.0, *)
public struct ImageCardListView: View, ImageListViewComponent {

    // MARK: - Public Properties
    
    /// The image displayed in the image view.
    @Binding public var cardImage: Image
    
    @State public var isHighlighted: Bool = false
    @State public var isHighlightedEnabled: Bool = true
    
    // MARK: Internal Properties
    
    @Environment(\.isEnabled) var isEnabled
    
    var renderingMode: Image.TemplateRenderingMode
    @ObservedObject private var schemeProvider: SchemeProvider<ImageCardListViewScheme>
    
    // MARK: - Initializer
    
    /// Initializes and returns a newly allocated view object with the zero frame rectangle.
    public init(
        cardImage: Image,
        renderingMode: Image.TemplateRenderingMode = .original,
        schemeProvider: SchemeProvider<ImageCardListViewScheme> = AppThemeSchemeProvider<ImageCardListViewScheme>()
    ) {
        self._cardImage = Binding(get: { return cardImage }, set: { _ in })
        self.renderingMode = renderingMode
        self.schemeProvider = schemeProvider
    }

    // MARK: - Body

    public var body: some View {
        let scheme = schemeProvider.scheme
        switch renderingMode {
        case .original:
            cardImage
                .frame(width: LayoutGrid.halfModule * 10, height: LayoutGrid.halfModule * 7, alignment: .leading)
                .cornerRadius(LayoutGrid.halfModule)
                .opacity(scheme.imageViewAlpha.parameter(for: isEnabled ? .normal : .disabled) ?? 1.0)
        case .template:
            cardImage
                .frame(width: LayoutGrid.halfModule * 10, height: LayoutGrid.halfModule * 7, alignment: .leading)
                .cornerRadius(LayoutGrid.halfModule)
                .foregroundColor(scheme.imageTintColor.parameter(for: isEnabled ? .normal : .disabled)?.swiftUIColor)
        @unknown default:
            Spacer()
        }
    }
    
    // MARK: - Internal Methods
    
    func scheme(_ scheme: ImageCardListViewScheme) -> some View {
        var view = self
        view.schemeProvider = .constant(scheme: scheme)
        return view.id(UUID())
    }
    
}

