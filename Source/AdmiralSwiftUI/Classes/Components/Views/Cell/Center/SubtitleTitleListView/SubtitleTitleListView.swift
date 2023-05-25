//
//  SubtitleTitleListView.swift
//  AdmiralSwiftUI
//
//  Created on 07.06.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources

/**
 SubtitleTitleListView - A view object with subtitle and title.
 
 You can create a SubtitleTitleListView with the zero frame rectangle by specifying the following parameters in init:

 - title: String? - The text that the label displays.
 - subtitle: String? - The text that the subtitle label displays.
 - lineLimit: Int? -  Line limit of title text.
 - titleListViewStyle: TitleSubtitleListViewStyle? - A style for display text of TitleSubtitleListView
 
 ## Example to create SubtitleTitleListView
 # Code
 ```
 static var previews: some View {
    SubtitleTitleListView(
                    title: "title",
                    subtitle: "First text",
                    lineLimit: 1)
 
    SubtitleTitleListView(
                    title: "title",
                    subtitle: "Second text")
    }
 )
```
 */
/// A view object with subtitle and title.
@available(iOS 14.0.0, *)
public struct SubtitleTitleListView: View, CenterListViewComponent {
    
    @State public var isHighlighted: Bool = false
    @State public var isHighlightedEnabled: Bool = true
    
    /// The text that the label displays.
    @Binding public var title: String?
    
    /// The text that the subtitle label displays.
    @Binding public var subtitle: String?
    
    // MARK: Internal Properties
    
    @Environment(\.isEnabled) var isEnabled
    
    /// The state of the view. Default is normal.
    @State var state: ControlState = .normal
    
    /// Text style.
    var titleSubtitleListViewStyle: TitleSubtitleListViewStyle?

    // MARK: - Private Properties

    private let lineLimit: Int?
    
    @ObservedObject private var schemeProvider: SchemeProvider<SubtitleTitleListViewScheme>

    // MARK: - Initializer
    
    /// Initializes and returns a newly allocated view object with the zero frame rectangle.
    public init(
        title: String?,
        subtitle: String?,
        lineLimit: Int? = nil,
        titleSubtitleListViewStyle: TitleSubtitleListViewStyle? = nil,
        schemeProvider: SchemeProvider<SubtitleTitleListViewScheme> = AppThemeSchemeProvider<SubtitleTitleListViewScheme>()
    ) {
        self._title = Binding(get: { return title }, set: { _ in })
        self._subtitle = Binding(get: { return subtitle }, set: { _ in })
        self.lineLimit = lineLimit
        self.titleSubtitleListViewStyle = titleSubtitleListViewStyle
        self.schemeProvider = schemeProvider
    }
    
    public var body: some View {
        let scheme = schemeProvider.scheme
        HStack(spacing: 0.0) {
            VStack(alignment: .leading, spacing: 4.0) {
                if let subtitle = subtitle {
                    Text(subtitle)
                        .multilineTextAlignment(.leading)
                        .font(scheme.subtitleFont.parameter(for: .normal, style: titleSubtitleListViewStyle)?.swiftUIFont)
                        .foregroundColor(
                            isEnabled ? scheme.subtitleColor.parameter(for: .normal)?.swiftUIColor
                            : scheme.subtitleColor.parameter(for: .disabled)?.swiftUIColor
                        )
                }
                if let title = title {
                    Text(title)
                        .multilineTextAlignment(.leading)
                        .lineLimit(lineLimit)
                        .font(scheme.titleFont.parameter(for: .normal, style: titleSubtitleListViewStyle)?.swiftUIFont)
                        .foregroundColor(
                            isEnabled ? scheme.titleColor.parameter(for: .normal)?.swiftUIColor
                            : scheme.titleColor.parameter(for: .disabled)?.swiftUIColor
                        )
                }
            }
            Spacer(minLength: 0.0)
        }
    }
    
}

@available(iOS 14.0, *)
struct SubtitleTitleListView_Previews: PreviewProvider {

    static var previews: some View {
        SubtitleTitleListView(
            title: """
            Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quo minus id quod maxime placeat facere possimus,
            omnis voluptas assumenda est, omnis dolor repellendus. Temporibus autem quibusdam et aut officiis debitis aut rerum
            necessitatibus saepe eveniet ut et voluptates repudiandae sint et molestiae non recusandae.
            Itaque earum rerum hic tenetur a sapiente delectus, ut aut reiciendis voluptatibus maiores alias
            consequatur aut perferendis doloribus asperiores repellat
            """,
            subtitle: "subtitle",
            lineLimit: 2
        )
        SubtitleTitleListView(
            title: """
            Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quo minus id quod maxime placeat facere possimus,
            omnis voluptas assumenda est, omnis dolor repellendus. Temporibus autem quibusdam et aut officiis debitis aut rerum
            necessitatibus saepe eveniet ut et voluptates repudiandae sint et molestiae non recusandae.
            Itaque earum rerum hic tenetur a sapiente delectus, ut aut reiciendis voluptatibus maiores alias consequatur
            aut perferendis doloribus asperiores repellat
            """,
            subtitle: "subtitle"
        )
    }

}
