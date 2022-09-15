//
//  TitleWithImageListView.swift
//  AdmiralSwiftUI
//
//  Created on 23.06.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources

/**
 TitleWithImageListStyle - Public enum for ImageCardListView
 
 TitleWithImageListStyle can be one of the following values:
 - title
 - body
 - headline
 */
public enum TitleWithImageListStyle: String {
    case title
    case body
    case headline
}

/**
 TitleWithImageListView - A view object with title, more label, detaile label and message view.
 
 You can create a TitleWithImageListView with the zero frame rectangle by specifying the following parameters in init:

 - title: String? - The text that the subtitle label displays.
 - image: Image? - The image displayed in the image view.
 - renderingMode: Image.TemplateRenderingMode - A type that indicates how SwiftUI renders images. By default is .original.
 - lineLimit: Int? - Line limit of title text. By default is nil.
 - titleWithImageListStyle: TitleWithImageListStyle - A style for TitleWithImageListView.  By default is nil
 
 ## Example to create TitleWithImageListView
 # Code
 ```
 TitleWithImageListView(
                title: "Title",
                image: nil,
                renderingMode: .original)
```
 */
/// A view object with title label and image view.
@available(iOS 14.0, *)
public struct TitleWithImageListView: View, LeadingListViewComponent {
    
    // MARK: - Public Properties
    
    /// The text that the subtitle label displays.
    @Binding var title: String?
    
    /// The image displayed in the image view.
    @Binding var image: Image?
    
    @State public var isHighlighted: Bool = false
    @State public var isHighlightedEnabled: Bool = true
    
    // MARK: Internal Properties
    
    @Environment(\.isEnabled) var isEnabled
    
    var titleWithImageListStyle: TitleWithImageListStyle?
    
    var renderingMode: Image.TemplateRenderingMode

    // MARK: - Private Properties

    @ObservedObject private var schemeProvider: SchemeProvider<TitleWithImageListViewScheme>
    private let lineLimit: Int?
    
    // MARK: - Initializer
    
    /// Initializes and returns a newly allocated view object with the zero frame rectangle.
    public init(
        title: String?,
        image: Image?,
        renderingMode: Image.TemplateRenderingMode = .original,
        lineLimit: Int? = nil,
        titleWithImageListStyle: TitleWithImageListStyle? = nil,
        schemeProvider: SchemeProvider<TitleWithImageListViewScheme> = AppThemeSchemeProvider<TitleWithImageListViewScheme>()
    ) {
        self._title = Binding(get: { return title }, set: { _ in })
        self._image = Binding(get: { return image }, set: { _ in })
        self.renderingMode = renderingMode
        self.lineLimit = lineLimit
        self.titleWithImageListStyle = titleWithImageListStyle
        self.schemeProvider = schemeProvider
    }

    // MARK: - Body

    public var body: some View {
        let scheme = schemeProvider.scheme
        HStack(alignment: .center, spacing: LayoutGrid.module) {
            if let title = title {
                Text(title)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(scheme.titleLabelTextColor.parameter(for: isEnabled ? .normal : .disabled)?.swiftUIColor)
                    .lineLimit(lineLimit)
                    .font(scheme.titleFont.parameter(for: .normal, style: titleWithImageListStyle)?.swiftUIFont)
            }
            if let image = self.image {
                imageView(image: image, scheme: scheme)
            }
        }
        .frame(height: LayoutGrid.halfModule * 7)
    }
    
    // MARK: - Private Functions
    
    private func imageView(image: Image, scheme: TitleWithImageListViewScheme) -> AnyView {
        switch renderingMode {
        case .original:
            return image
                .aspectRatio(contentMode: .fit)
                .opacity(scheme.imageViewAlpha.parameter(for: isEnabled ? .normal : .disabled) ?? 1.0)
                .eraseToAnyView()
        case .template:
            return image
                .aspectRatio(contentMode: .fit)
                .foregroundColor(scheme.imageTintColor.parameter(for: isEnabled ? .normal : .disabled)?.swiftUIColor)
                .eraseToAnyView()
        @unknown default:
            return Spacer()
                .eraseToAnyView()
        }
    }
    
}

@available(iOS 14.0, *)
struct TitleWithImageListView_Previews: PreviewProvider {

    static var previews: some View {
        TitleWithImageListView(title: "Title", image: nil, renderingMode: .original)
    }

}



