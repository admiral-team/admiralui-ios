//
//  ImageTitleParagraph.swift
//  AdmiralSwiftUI
//
//  Created on 27.09.2021.
//

import SwiftUI
import AdmiralTheme
/**
 ParagraphView - A group of text components exists in several variants.
 You can create a ParagraphView by specifying the following parameters in the initializer
 ## Initializer parameters:
 - title: String? - The text that the label displays
 - paragraphImageType: ParagraphLeadingImageType? - A type of paragraph Image. Can be: point, check, custom (your image)
 - trailingImage: Image? - Trailing image.
 - textBlockStyle: TextBlockStyle - A style of title and subtitle text block. HeaderStyle can be: itle, body, headline, headlineSecondary, dropDown, paragraph, paragraphSecondary, link, separator, separatorShort, separatorEmpty
 - textAligment: TextAlignment - Alignment text
 - renderingMode: Image.TemplateRenderingMode - Rendering mode for image
 ## Example to create ParagraphView with different parameters:
 # Code
 ```
 List {
     ParagraphView(
         title: "Title",
         paragraphImageType: .check,
         textAligment: .leading,
         paragraphStyle: .primary)

     ParagraphView(
         title: "Title",
         paragraphImageType: .point,
         textAligment: .leading,
         paragraphStyle: .secondary)

     ParagraphView(
         title: "Title",
         textAligment: .leading,
         paragraphStyle: .primary)

     ParagraphView(
         title: "Title",
         textAligment: .center,
         paragraphStyle: .secondary)

     ParagraphView(
         title: "Title",
         trailingImage: Image("Your image"),
         textAligment: .center,
         paragraphStyle: .secondary)
 }
 ```
*/
/// Paragraph view.
@available(iOS 14.0.0, *)
public struct ParagraphView: View {

    /// The text that the label displays.
    @Binding public var title: String?

    /// Paragraph image type.
    @Binding public var paragraphImageType: ParagraphLeadingImageType?

    /// Trailing image.
    @Binding public var trailingImage: Image?

    /// Text block style.
    public var textBlockStyle: TextBlockStyle

    @Binding var textAligment: TextAlignment

    /// Image rendering mode.
    @Binding public var renderingMode: Image.TemplateRenderingMode

    // MARK: - Private Properties

    @ObservedObject private var schemeProvider: SchemeProvider<ParagraphViewScheme>

    // MARK: - Initializer

    /// Initializes and returns a newly allocated view object with the zero frame rectangle.
    public init(
        title: String?,
        paragraphImageType: ParagraphLeadingImageType? = nil,
        renderingMode: Image.TemplateRenderingMode = .template,
        trailingImage: Image? = nil,
        textAligment: TextAlignment = .leading,
        paragraphStyle: ParagraphStyle = .primary,
        schemeProvider: SchemeProvider<ParagraphViewScheme> = AppThemeSchemeProvider<ParagraphViewScheme>()
    ) {
        self._title = Binding(get: { return title }, set: { _ in })
        self._paragraphImageType = Binding(get: { return paragraphImageType }, set: { _ in })
        self._trailingImage = Binding(get: { return trailingImage }, set: { _ in })
        self.textBlockStyle = paragraphStyle.textBlockStyle
        self._renderingMode = Binding(get: { return renderingMode }, set: { _ in })
        self._textAligment = Binding(get: { return textAligment }, set: { _ in })
        self.schemeProvider = schemeProvider
    }

    // MARK: - Body

    public var body: some View {
        let imageListViewStyle: ImageListViewStyle
        switch textBlockStyle {
        case .paragraph, .paragraphSecondary:
            imageListViewStyle = .secondary
        default:
            imageListViewStyle = .primary
        }
        let titleListViewStyle = TitleListViewStyle(rawValue: textBlockStyle.rawValue)
        let iconListViewStyle = IconListViewStyle(rawValue: textBlockStyle.rawValue)
        return ListCell(
            leadingView: paragraphImageType != nil ? {
                ImageListView(
                    image: paragraphImageType?.image ?? Image(""),
                    renderingMode: renderingMode,
                    imageListViewStyle: imageListViewStyle,
                    schemeProvider: .constant(scheme: schemeProvider.scheme.leadingViewScheme)
                )
            } : nil,
            centerView: {
                TitleListView(
                    title: title,
                    textAligment: textAligment,
                    titleListViewStyle: titleListViewStyle,
                    schemeProvider: .constant(scheme: schemeProvider.scheme.centerViewScheme)
                )
            },
            trailingView: trailingImage != nil ? {
                IconListView(
                    image: trailingImage ?? Image(""),
                    renderingMode: renderingMode,
                    iconListViewStyle: iconListViewStyle,
                    schemeProvider: .constant(scheme: schemeProvider.scheme.trailingViewScheme)
                )
            } : nil)
            .configCell(
                minHeight: textBlockStyle.minHeight,
                edgeInsets: textBlockStyle.edgeInsets,
                leadingViewWidth: LayoutGrid.tripleModule,
                schemeProvider: .constant(scheme: schemeProvider.scheme.listCellScheme)
            )
    }
}

@available(iOS 14.0, *)
struct ImageTitleParagraph_Previews: PreviewProvider {
    static var previews: some View {
        List {
            ParagraphView(
                title: "Title",
                paragraphImageType: .check,
                textAligment: .leading,
                paragraphStyle: .primary)

            ParagraphView(
                title: "Title",
                paragraphImageType: .point,
                textAligment: .leading,
                paragraphStyle: .secondary)

            ParagraphView(
                title: "Title",
                textAligment: .leading,
                paragraphStyle: .primary)

            ParagraphView(
                title: "Title",
                textAligment: .center,
                paragraphStyle: .secondary)

            ParagraphView(
                title: "Title",
                trailingImage: SymbolAssets.Service.Outline.closeCircle.swiftUIImage,
                textAligment: .center,
                paragraphStyle: .secondary)
        }
    }
}
