//
//  ImageListView.swift
//  AdmiralSwiftUI
//
//  Created on 22.06.2021.
//

import SwiftUI
import AdmiralCore
import AdmiralTheme
import AdmiralUIResources

/**
 ImageListViewStyle - Public enum for CardListView
 
 CardListView can be one of the following values:

 - primary: primary style
 - secondary: secondary style
 */
public enum ImageListViewStyle: String {
    case primary
    case secondary
}

/**
 ImageListView - The image displayed in the image view.
 
 You can create a ImageListView with a zero-frame rectangle using one of the two initializers.

 First init:
 - image: Image - The image displayed in the image view.
 - renderingMode: Image.TemplateRenderingMode - A type that indicates how SwiftUI renders images

 Second init:
 - image: Image - The image displayed in the image view.
 - renderingMode: Image.TemplateRenderingMode - A type that indicates how SwiftUI renders images
 - imageListViewStyle: ImageListViewStyle - A style of ImageListView
 
 ## Example to create ImageListView
 # Code
 ```
 ImageListView(image: Image("Your image"))
```
 */
/// A view object with image view.
@available(iOS 14.0, *)
public struct ImageListView: View, LeadingListViewComponent {

    // MARK: - Public Properties
    
    /// The image displayed in the image view.
    @Binding public var image: Image
    
    @State public var isHighlighted: Bool = false
    @State public var isHighlightedEnabled: Bool = true
    
    // MARK: Internal Properties
    
    @Environment(\.isEnabled) var isEnabled
    
    @State var imageListViewStyle: ImageListViewStyle = .primary
    
    var renderingMode: Image.TemplateRenderingMode

    @ObservedObject private var schemeProvider: SchemeProvider<ImageListViewScheme>
    
    // MARK: - Initializer
    
    /// Initializes and returns a newly allocated view object with the zero frame rectangle.
    public init(
        image: Image,
        renderingMode: Image.TemplateRenderingMode = .original,
        schemeProvider: SchemeProvider<ImageListViewScheme> = AppThemeSchemeProvider<ImageListViewScheme>()
    ) {
        self._image = Binding(get: { return image }, set: { _ in })
        self.renderingMode = renderingMode
        self.schemeProvider = schemeProvider
    }
    
    /// Initializes and returns a newly allocated view object with the zero frame rectangle.
    public init(
        image: Image,
        renderingMode: Image.TemplateRenderingMode = .original,
        imageListViewStyle: ImageListViewStyle,
        schemeProvider: SchemeProvider<ImageListViewScheme> = AppThemeSchemeProvider<ImageListViewScheme>()
    ) {
        self._image = Binding(get: { return image }, set: { _ in })
        self.renderingMode = renderingMode
        self._imageListViewStyle = .init(initialValue: imageListViewStyle)
        self.schemeProvider = schemeProvider
    }
    
    public var body: some View {
        let scheme = schemeProvider.scheme
        switch renderingMode {
        case .original:
            image
                .opacity(scheme.imageViewAlpha.parameter(for: isEnabled ? .normal : .disabled) ?? 1.0)
        case .template:
            image
                .foregroundColor(scheme.imageTintColor.parameter(for: isEnabled ? .normal : .disabled, style: imageListViewStyle)?.swiftUIColor)
        @unknown default:
            Spacer()
        }
    }
    
}
