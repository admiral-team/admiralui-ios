//
//  SubtitleImageArrowListView.swift
//  AdmiralSwiftUI
//
//  Created on 22.11.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources

/**
 SubtitleImageArrowListView - A view object with subtitle label and image view.
 
 You can create a SubtitleImageArrowListView with the zero frame rectangle by specifying the following parameters in init:
 - subtitle: String? - The text that the subtitle label displays.
 - image: Image? - The image displayed in the image view.
 
 SubtitleImageArrowListView has a public property:
 - isHighlighted: Bool - A Boolean value indicating whether the view is in the highlighted state.
 - isHighlightedEnabled: Bool - A Boolean value indicating whether the view can  draws a highlight.
 
 ## Example to create SubtitleImageArrowListView
 # Code
 ```
 SubtitleWithImageListView(
                    subtitle: "Subtitle",
                    image: Image("Your image"))
```
 */
/// A view object with subtitle label and image view.
@available(iOS 14.0, *)
public struct SubtitleImageArrowListView: View, TralingListViewComponent {
    
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

    @ObservedObject private var schemeProvider: SchemeProvider<SubtitleImageArrowListViewScheme>
    
    // MARK: - Initializer
    
    /// Initializes and returns a newly allocated view object with the zero frame rectangle.
    public init(
        subtitle: String?,
        image: Image?,
        renderingMode: Image.TemplateRenderingMode = .original,
        schemeProvider: SchemeProvider<SubtitleImageArrowListViewScheme> = AppThemeSchemeProvider<SubtitleImageArrowListViewScheme>()
    ) {
        self._subtitle = Binding(get: { return subtitle }, set: { _ in })
        self._image = Binding(get: { return image }, set: { _ in })
        self.renderingMode = renderingMode
        self.schemeProvider = schemeProvider
    }

    // MARK: - Body

    public var body: some View {
        let scheme = schemeProvider.scheme
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
            Image(uiImage: Asset.System.Outline.chevronRightOutline.image)
                .frame(width: LayoutGrid.module, height: LayoutGrid.doubleModule)
                .foregroundColor(scheme.arrowTintColor.parameter(for: isEnabled ? .normal : .disabled)?.swiftUIColor)
        }
        .frame(width: LayoutGrid.doubleModule * 9, height: LayoutGrid.doubleModule * 3)
    }
    
    // MARK: - Private Functions
    
    private func imageView(image: Image, scheme: SubtitleImageArrowListViewScheme) -> AnyView {
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
