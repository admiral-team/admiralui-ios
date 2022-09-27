//
//  TitleDropDownHeader.swift
//  AdmiralSwiftUI
//
//  Created on 23.09.2021.
//
import SwiftUI
import AdmiralTheme
import AdmiralUIResources
/**
 DropDownHeader - A header with header title, arrow and button.

 You can create a DropDownHeader by specifying the following parameters in the initializer

 ## Initializer parameters:

 - title: String? - Title text block
 - dropDownHeaderType: DropDownHeaderType? - A type of header. DropDownHeaderType can be: up, down, custom
 - textBlockStyle: TextBlockStyle - A style of title and subtitle text block. HeaderStyle can be: title, body, headline, headlineSecondary, dropDown, paragraph, paragraphSecondary, link, separator, separatorShort, separatorEmpty
 - renderingMode: Image.TemplateRenderingMode - Rendering mode for image

 ## Example to create DropDownHeader with title and dropDownHeaderType:
 # Code
 ```
 Group {
     DropDownHeader(title: "Title")
     DropDownHeader(title: "Title", dropDownHeaderType: .down)
 }
 ```
*/
/// A header with header title.
@available(iOS 14.0.0, *)
public struct DropDownHeader: View {

    /// The text that the label displays.
    @Binding public var title: String?

    /// Drop down header type.
    @Binding public var dropDownHeaderType: DropDownHeaderType

    /// Text block style.
    public var textBlockStyle: TextBlockStyle

    /// Image rendering mode.
    public var renderingMode: Image.TemplateRenderingMode

    // MARK: - Private Properties

    @ObservedObject private var schemeProvider: SchemeProvider<DropDownHeaderScheme>

    // MARK: - Initializer

    /// Initializes and returns a newly allocated view object with the zero frame rectangle.
    public init(
        title: String?,
        dropDownHeaderType: DropDownHeaderType = .down,
        renderingMode: Image.TemplateRenderingMode = .original,
        headerStyle: HeaderStyle = .title,
        schemeProvider: SchemeProvider<DropDownHeaderScheme> = AppThemeSchemeProvider<DropDownHeaderScheme>()
    ) {
        self._title = Binding(get: { return title }, set: { _ in })
        self.textBlockStyle = headerStyle.textBlockStyle
        self._dropDownHeaderType = Binding(get: { return dropDownHeaderType }, set: { _ in })
        self.renderingMode = renderingMode
        self.schemeProvider = schemeProvider
    }

    // MARK: - Body

    public var body: some View {
        let titleListViewStyle = TitleListViewStyle(rawValue: textBlockStyle.rawValue)
        return ListCell(centerView: {
            TitleListView(
                title: title,
                titleListViewStyle: titleListViewStyle,
                schemeProvider: .constant(scheme: schemeProvider.scheme.centerViewScheme)
            )
        },
        trailingView: {
            IconListView(
                image: dropDownHeaderType.image.renderingMode(renderingMode),
                renderingMode: renderingMode,
                schemeProvider: .constant(scheme: schemeProvider.scheme.trailingViewScheme)
            )})
        .configCell(
            minHeight: textBlockStyle.minHeight,
            edgeInsets: textBlockStyle.edgeInsets,
            schemeProvider: .constant(scheme: schemeProvider.scheme.listCellScheme)
        )
    }
}

@available(iOS 14.0, *)
struct TitleDropDownHeader_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DropDownHeader(title: "Title")
            DropDownHeader(title: "Title", dropDownHeaderType: .down)
        }
    }
}
