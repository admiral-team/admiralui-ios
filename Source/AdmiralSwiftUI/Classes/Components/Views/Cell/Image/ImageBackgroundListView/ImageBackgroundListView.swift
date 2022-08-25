//
//  ImageBackgroundListView.swift
//  AdmiralSwiftUI
//
//  Created on 22.06.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources

/**
 ImageBackgroundListView - A view object with card image view.
 
 You can create a ImageBackgroundListView with the zero frame rectangle by specifying the following parameters in init:

 - image: Image - The image displayed in the image view.
 - renderingMode: Image.TemplateRenderingMode - A type that indicates how SwiftUI renders images
 
 ## Example to create ImageBackgroundListView
 # Code
 ```
 ImageBackgroundListView(
                image: Image("Your image"),
                renderingMode: .template)
```
 */
/// A view object with background view and image view.
@available(iOS 14.0, *)
public struct ImageBackgroundListView: View, ImageListViewComponent {

    // MARK: - Public Properties
    
    /// The image displayed in the image view.
    @Binding public var image: Image
    
    @State public var isHighlighted: Bool = false
    @State public var isHighlightedEnabled: Bool = true
    
    // MARK: Internal Properties
    
    @Environment(\.isEnabled) var isEnabled
    @Environment(\.manager) var manager
    
    var renderingMode: Image.TemplateRenderingMode
    @State private var scheme: ImageBackgroundListViewScheme? = nil
    @ObservedObject private var schemeProvider = SwiftUISchemeProvider<ImageBackgroundListViewScheme>()
    
    // MARK: - Initializer
    
    /// Initializes and returns a newly allocated view object with the zero frame rectangle.
    public init(image: Image, renderingMode: Image.TemplateRenderingMode = .original) {
        self._image = Binding(get: { return image }, set: { _ in })
        self.renderingMode = renderingMode
    }

    public var body: some View {
        let scheme = self.scheme ?? schemeProvider.scheme
        imageView(scheme: scheme)
            .frame(width: LayoutGrid.halfModule * 11, height: LayoutGrid.halfModule * 11)
            .background(scheme.backgroundImageViewColor.parameter(for: isEnabled ? .normal : .disabled)?.swiftUIColor)
            .cornerRadius((LayoutGrid.halfModule * 11) / 2)
    }
    
    // MARK: - Internal Methods
    
    func scheme(_ scheme: ImageBackgroundListViewScheme) -> some View {
        var view = self
        view._scheme = State(initialValue: scheme)
        return view.id(UUID())
    }
    
    // MARK: - Private Methods
    
    private func imageView(scheme: ImageBackgroundListViewScheme) -> AnyView {
        switch renderingMode {
        case .original:
            return image
                .opacity(scheme.imageViewAlpha.parameter(for: isEnabled ? .normal : .disabled) ?? 1.0)
                .eraseToAnyView()
        case .template:
            return image
                .foregroundColor(scheme.imageTintColor.parameter(for: isEnabled ? .normal : .disabled)?.swiftUIColor)
                .eraseToAnyView()
        @unknown default:
            return Spacer()
                .eraseToAnyView()
        }
    }
    
}

