//
//  HeaderTitle.swift
//  AdmiralSwiftUI
//
//  Created on 23.09.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources
/**
 TitleHeader - A header with header title, arrow and button.

 You can create a TitleHeader by specifying the following parameters in the initializer

 ## Initializer parameters:

 - title: String? - The text that the label displays
 - textAligment: TextAlignment - Alignment title text block
 - textBlockStyle: TextBlockStyle - A style of title and subtitle text block. HeaderStyle can be: title, body, headline, headlineSecondary, dropDown, paragraph, paragraphSecondary, link, separator, separatorShort, separatorEmpty

 ## Example to create TitleHeader with title and textAligment:
 # Code
 ```
 Group {
     TitleHeader(title: "Title")
     TitleHeader(title: "Title", textAligment: .center)
 }
 ```
*/
/// A header with header title.
@available(iOS 14.0.0, *)
public struct TitleHeader: View {

    /// The text that the label displays.
    @Binding public var title: String?

    /// The alignment of TitleHeader.
    @Binding public var textAligment: TextAlignment

    /// Text block style.
    public var textBlockStyle: TextBlockStyle

    // MARK: - Initializer

    /// Initializes and returns a newly allocated view object with the zero frame rectangle.
    public init(title: String?, textAligment: TextAlignment = .leading, headerStyle: HeaderStyle = .title) {
        self._title = Binding(get: { return title }, set: { _ in })
        self.textBlockStyle = headerStyle.textBlockStyle
        self._textAligment = Binding(get: { return textAligment }, set: { _ in })
    }

    // MARK: - Body

    public var body: some View {
        let titleListViewStyle = TitleListViewStyle(rawValue: textBlockStyle.rawValue)
        return ListCell(centerView: {
            TitleListView(
                title: title,
                textAligment: textAligment,
                titleListViewStyle: titleListViewStyle)
        })
        .configCell(minHeight: textBlockStyle.minHeight, edgeInsets: textBlockStyle.edgeInsets)
    }
}

@available(iOS 14.0, *)
struct TitleHeader_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TitleHeader(title: "Title")
                .previewLayout(.sizeThatFits)
            TitleHeader(title: "Title", textAligment: .center)
                .previewLayout(.sizeThatFits)
        }
    }
}
