//
//  SubtitleTitleHeader.swift
//  AdmiralSwiftUI
//
//  Created on 23.09.2021.
//
import SwiftUI
import AdmiralTheme
import AdmiralUIResources
/**
 SubtitleTitleHeader - A header with header subtitle and title.

 You can create a SubtitleTitleHeader by specifying the following parameters in the initializer

 ## Initializer parameters:a

 - title: String? - Title text block
 - subtitle: String? - Subtitle text block
 - textBlockStyle: TextBlockStyle - A style of title and subtitle text block. HeaderStyle can be: itle, body, headline, headlineSecondary, dropDown, paragraph, paragraphSecondary, link, separator, separatorShort, separatorEmpty

 ## Example to create vertical SubtitleTitleHeader:
 # Code
 ```
 SubtitleTitleHeader(title: "Title", subtitle: "Subtitle")
 ```
*/
/// A header with header subtitle and title.
@available(iOS 14.0.0, *)
public struct SubtitleTitleHeader: View {

    // MARK: - Properties

    /// The text that the title label displays.
    @Binding public var title: String?

    /// The text that the subtitle label displays.
    @Binding public var subtitle: String?

    /// Text block style.
    public var textBlockStyle: TextBlockStyle

    // MARK: - Private Properties

    @ObservedObject private var schemeProvider: SchemeProvider<SubtitleTitleHeaderScheme>

    // MARK: - Initializer

    /// Initializes and returns a newly allocated view object with the zero frame rectangle.
    public init(
        title: String?,
        subtitle: String?,
        headerStyle: HeaderStyle = .title,
        schemeProvider: SchemeProvider<SubtitleTitleHeaderScheme> = AppThemeSchemeProvider<SubtitleTitleHeaderScheme>()
    ) {
        self._title = Binding(get: { return title }, set: { _ in })
        self._subtitle = Binding(get: { return subtitle }, set: { _ in })
        self.textBlockStyle = headerStyle.textBlockStyle
        self.schemeProvider = schemeProvider
    }

    // MARK: - Body

    public var body: some View {
        let titleSubtitleListViewStyle = TitleSubtitleListViewStyle(rawValue: textBlockStyle.rawValue)
        return ListCell(centerView: {
            SubtitleTitleListView(
                title: title,
                subtitle: subtitle,
                titleSubtitleListViewStyle: titleSubtitleListViewStyle,
                schemeProvider: .constant(scheme: schemeProvider.scheme.centerViewScheme)
            )
        })
        .configCell(
            minHeight: textBlockStyle.minHeight,
            edgeInsets: textBlockStyle.edgeInsets,
            schemeProvider: .constant(scheme: schemeProvider.scheme.listCellScheme)
        )
    }
}

@available(iOS 14.0, *)
struct SubtitleTitleHeader_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SubtitleTitleHeader(title: "Title", subtitle: "Subtitle")
        }
    }
}
