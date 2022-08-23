//
//  IconListView.swift
//  AdmiralSwiftUI
//
//  Created on 21.06.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources

/**
 IconListViewStyle - Public enum for ImageCardListView
 
 IconListViewStyle can be one of the following values:

 - paragraph
 - paragraphSecondary
 */
public enum IconListViewStyle: String {
    case paragraph
    case paragraphSecondary
}

/**
 IconListView - A view object with icon view.
 
 You can create a IconListView with the zero frame rectangle by specifying the following parameters in init:
 - image: Image - The image displayed in the image view.
 - renderingMode: Image.TemplateRenderingMode - The Image template rendering mod. Default state is .original
 - iconListViewStyle: IconListViewStyle? - The style of IconListView
 
 ## Example to create IconListView
 # Code
 ```
 IconListView(image: Image("Your icon list image"))
```
 */
/// A view object with icon view.
@available(iOS 14.0, *)
public struct IconListView: View, TralingListViewComponent {

    // MARK: - Public Properties
    
    /// The image displayed in the image view.
    @Binding public var image: Image
    
    @State public var isHighlighted: Bool = false
    @State public var isHighlightedEnabled: Bool = true
    
    // MARK: Internal Properties
    
    @Environment(\.isEnabled) var isEnabled
    
    var iconListViewStyle: IconListViewStyle?
    
    var renderingMode: Image.TemplateRenderingMode
    
    @Binding private var scheme: IconListViewScheme?
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<IconListViewScheme>()
    
    // MARK: - Initializer
    
    /// Initializes and returns a newly allocated view object with the zero frame rectangle.
    public init(
        image: Image,
        renderingMode: Image.TemplateRenderingMode = .original,
        iconListViewStyle: IconListViewStyle? = nil,
        scheme: Binding<IconListViewScheme?> = .constant(nil)
    ) {
        self._image = Binding(get: { return image }, set: { _ in })
        self.renderingMode = renderingMode
        self.iconListViewStyle = iconListViewStyle
        self._scheme = scheme
    }

    // MARK: - Body

    public var body: some View {
        let scheme = self.scheme ?? schemeProvider.scheme
        switch renderingMode {
        case .original:
            image
                .opacity(scheme.imageViewAlpha.parameter(for: isEnabled ? .normal : .disabled) ?? 1.0)
        case .template:
            image
                .foregroundColor(scheme.imageTintColor.parameter(for: isEnabled ? .normal : .disabled, style: iconListViewStyle)?.swiftUIColor)
        @unknown default:
            Spacer()
        }
    }
    
}
