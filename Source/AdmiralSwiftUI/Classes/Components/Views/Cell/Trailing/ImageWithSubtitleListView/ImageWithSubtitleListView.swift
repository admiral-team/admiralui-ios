//
//  ImageWithSubtitleListView.swift
//  AdmiralSwiftUI
//
//  Created on 21.06.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources

/**
 ImageWithSubtitleListView - A view object with subtitle label and image view.
 
 You can create a ImageWithSubtitleListView with the zero frame rectangle by specifying the following parameters in init:
 - subtitle: String? - The text that the subtitle label displays.
 - image: Image? - The image displayed in the image view.
 
 ImageWithSubtitleListView has a public property:
 - isHighlighted: Bool - A Boolean value indicating whether the view is in the highlighted state.
 - isHighlightedEnabled: Bool - A Boolean value indicating whether the view can  draws a highlight.
 
 ## Example to create ImageWithSubtitleListView
 # Code
 ```
 ImageWithSubtitleListView(
                    subtitle: "Subtitle",
                    image: Image("Your image"))
```
 */
/// A view object with subtitle label and image view.
@available(iOS 14.0, *)
public struct ImageWithSubtitleListView: View, TralingListViewComponent {
    
    // MARK: - Public Properties
    
    /// The text that the subtitle label displays.
    @Binding var subtitle: String?
    
    /// The image displayed in the image view.
    @Binding var image: Image?
    
    @State public var isHighlighted: Bool = false
    @State public var isHighlightedEnabled: Bool = true
    
    // MARK: Internal Properties
    
    @Environment(\.isEnabled) var isEnabled
    
    var renderingMode: Image.TemplateRenderingMode
    @State private var scheme: ImageWithSubtitleListViewScheme? = nil
    @ObservedObject private var schemeProvider = SwiftUISchemeProvider<ImageWithSubtitleListViewScheme>()
    
    // MARK: - Initializer
    
    /// Initializes and returns a newly allocated view object with the zero frame rectangle.
    public init(subtitle: String?, image: Image?, renderingMode: Image.TemplateRenderingMode = .original) {
        self._subtitle = Binding(get: { return subtitle }, set: { _ in })
        self._image = Binding(get: { return image }, set: { _ in })
        self.renderingMode = renderingMode
    }

    public var body: some View {
        let scheme = self.scheme ?? schemeProvider.scheme
        HStack(spacing: LayoutGrid.module) {
            Spacer()
            if let image = self.image {
                imageView(image: image, scheme: scheme)
            }
            if let subtitle = subtitle {
                Text(subtitle)
                    .foregroundColor(scheme.subtitleLabelTextColor.parameter(for: isEnabled ? .normal : .disabled)?.swiftUIColor)
                    .font(scheme.subtitleFont.swiftUIFont)
            }
        }
        .frame(width: LayoutGrid.doubleModule * 7, height: LayoutGrid.doubleModule * 3)
    }
    
    // MARK: - Private Functions
    
    private func imageView(image: Image, scheme: ImageWithSubtitleListViewScheme) -> AnyView {
        switch renderingMode {
        case .original:
            return image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: LayoutGrid.halfModule * 7, height: LayoutGrid.doubleModule)
                .opacity(scheme.imageViewAlpha.parameter(for: isEnabled ? .normal : .disabled) ?? 1.0)
                .eraseToAnyView()
        case .template:
            return image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: LayoutGrid.halfModule * 7, height: LayoutGrid.doubleModule)
                .foregroundColor(scheme.imageTintColor.parameter(for: isEnabled ? .normal : .disabled)?.swiftUIColor)
                .eraseToAnyView()
        @unknown default:
            return Spacer()
                .eraseToAnyView()
        }
    }
    
}



