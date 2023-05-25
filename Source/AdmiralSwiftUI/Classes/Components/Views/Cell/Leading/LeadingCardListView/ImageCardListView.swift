//
//  CardListView.swift
//  AdmiralUIResources
//
//  Created on 22.06.2021.
//

import SwiftUI
import AdmiralTheme

/**
 LeadingCardListView - A view object with card image view.
 
 You can create a LeadingCardListView with the zero frame rectangle by specifying the following parameters in init:

 - cardImage: Image - image for LeadingCardListView

 ## Example to create CardListView
 # Code
 ```
 LeadingCardListView(
            cardImage: Image("Your image"))
```
 */
/// A view object with card image view.
@available(iOS 14.0, *)
public struct LeadingCardListView: View, LeadingListViewComponent {

    // MARK: - Public Properties
    
    /// The image displayed in the image view.
    @Binding public var cardImage: Image
    
    @State public var isHighlighted: Bool = false
    @State public var isHighlightedEnabled: Bool = true
    
    // MARK: Internal Properties
    
    @Environment(\.isEnabled) var isEnabled
    
    var renderingMode: Image.TemplateRenderingMode
    @ObservedObject private var schemeProvider: SchemeProvider<LeadingCardListViewScheme>
    
    // MARK: - Initializer
    
    /// Initializes and returns a newly allocated view object with the zero frame rectangle.
    public init(
        cardImage: Image,
        renderingMode: Image.TemplateRenderingMode = .original,
        schemeProvider: SchemeProvider<LeadingCardListViewScheme> = AppThemeSchemeProvider<LeadingCardListViewScheme>()
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
    
}

