//
//  SubtitleWithImageListView.swift
//  AdmiralSwiftUI
//
//  Created on 21.06.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources

/**
 SubtitleWithImageListView - A view object with subtitle label and image view.
 
 You can create a SubtitleWithImageListView with the zero frame rectangle by specifying the following parameters in init:
 - subtitle: String? - The text that the subtitle label displays.
 - image: Image? - The image displayed in the image view.
 
 SubtitleWithImageListView has a public property:
 - isHighlighted: Bool - A Boolean value indicating whether the view is in the highlighted state.
 - isHighlightedEnabled: Bool - A Boolean value indicating whether the view can  draws a highlight.
 
 ## Example to create SubtitleWithImageListView
 # Code
 ```
 SubtitleWithImageListView(
                    subtitle: "Subtitle",
                    image: Image("Your image"))
```
 */
/// A view object with subtitle label and image view.
@available(iOS 14.0, *)
public struct SubtitleWithImageListView: View, TralingListViewComponent {
    
    // MARK: - Public Properties
    
    /// The text that the subtitle label displays.
    @Binding var subtitle: String?
    
    /// The image displayed in the image view.
    @Binding var image: Image?
    
    @State public var isHighlighted: Bool = false
    @State public var isHighlightedEnabled: Bool = true
    
    // MARK: Internal Properties
    
    @Environment(\.isEnabled) var isEnabled
    @Environment(\.manager) var manager
    
    var renderingMode: Image.TemplateRenderingMode
    @State private var scheme: SubtitleWithImageListViewScheme? = nil
    @ObservedObject private var schemeProvider: SchemeProvider<SubtitleWithImageListViewScheme>
    
    // MARK: - Initializer
    
    /// Initializes and returns a newly allocated view object with the zero frame rectangle.
    public init(
        subtitle: String?,
        image: Image?,
        renderingMode: Image.TemplateRenderingMode = .original,
        schemeProvider: SchemeProvider<SubtitleWithImageListViewScheme> = AppThemeSchemeProvider<SubtitleWithImageListViewScheme>()
    ) {
        self._subtitle = Binding(get: { return subtitle }, set: { _ in })
        self._image = Binding(get: { return image }, set: { _ in })
        self.renderingMode = renderingMode
        self.schemeProvider = schemeProvider
    }

    public var body: some View {
        let scheme = self.scheme ?? schemeProvider.scheme
        HStack(alignment: .center, spacing: LayoutGrid.module) {
            Spacer()
            if let subtitle = subtitle {
                Text(subtitle)
                    .foregroundColor(scheme.subtitleLabelTextColor.parameter(for: isEnabled ? .normal : .disabled)?.swiftUIColor)
                    .font(scheme.subtitleFont.swiftUIFont)
            }
            if let image = self.image {
                imageView(image: image, scheme: scheme)
            }
        }
        .frame(width: LayoutGrid.doubleModule * 7, height: LayoutGrid.doubleModule * 3)
    }
    
    // MARK: - Private Functions
    
    private func imageView(image: Image, scheme: SubtitleWithImageListViewScheme) -> AnyView {
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

