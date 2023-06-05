//
//  TitleSubtitleButtonListView.swift
//  AdmiralSwiftUI
//
//  Created on 07.06.2021.
//

import AdmiralTheme
import SwiftUI

/**
 TitleSubtitleButtonListView - A view object with title, more label, detaile label and message view.
 
 You can create a TitleSubtitleButtonListView with the zero frame rectangle by specifying the following parameters in init:

 - title: String? - The text that the title label displays.
 - tagSubtitle: String? - The text that the tag subtitle label displays.
 - tagText: String? - The text that the tag view displays.
 - subtitle: String? - The text that the more subtitle displays.
 - subtitleLineLimit: Int? - The line limit for subtitle text.
 - buttonTitle: String? - The text that the button displays.
 - buttonAction: (() -> ())? - The action button
 
 ## Example to create TitleSubtitleButtonListView
 # Code
 ```
 TitleSubtitleButtonListView(
     title: "title",
     tagSubtitle: "tagSubtitle",
     tagText: "tagText",
     subtitle: "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo",
     subtitleLineLimit: 3,
     buttonTitle: "button",
     buttonAction: nil
 )
```
 */
/// A view object with title, subtitle and button.
@available(iOS 14.0.0, *)
public struct TitleSubtitleButtonListView: View, CenterListViewComponent {

    // MARK: - Public Properties
    
    public var isHighlighted: Bool = false
    public var isHighlightedEnabled: Bool = true
    
    /// The text that the title label displays.
    @Binding public var title: String?

    /// The text that the tag subtitle label displays.
    @Binding public var tagSubtitle: String?
    
    /// The text that the tag view displays.
    @Binding public var tagText: String?
    
    /// The text that the more subtitle displays.
    @Binding public var subtitle: String?
    
    /// The text that the button displays.
    @Binding public var buttonTitle: String?
    
    /// The action button.
    public var buttonAction: () -> () = {}
    
    // MARK: Internal Properties
    
    @Environment(\.isEnabled) var isEnabled

    // MARK: - Private Properties

    @ObservedObject private var schemeProvider: SchemeProvider<TitleSubtitleButtonListViewScheme>
    private let subtitleLineLimit: Int?

    // MARK: - Initializer
    
    /// Initializes and returns a newly allocated view object with the zero frame rectangle.
    public init(
        title: String?,
        tagSubtitle: String?,
        tagText: String?,
        subtitle: String?,
        subtitleLineLimit: Int? = nil,
        buttonTitle: String?,
        schemeProvider: SchemeProvider<TitleSubtitleButtonListViewScheme> = AppThemeSchemeProvider<TitleSubtitleButtonListViewScheme>(),
        buttonAction: (() -> ())?
    ) {
        self._title = Binding(get: { return title }, set: { _ in })
        self._tagSubtitle = Binding(get: { return tagSubtitle }, set: { _ in })
        self._tagText = Binding(get: { return tagText }, set: { _ in })
        self._subtitle = Binding(get: { return subtitle }, set: { _ in })
        self._buttonTitle = Binding(get: { return buttonTitle }, set: { _ in })
        self.buttonAction = buttonAction ?? {}
        self.subtitleLineLimit = subtitleLineLimit
        self.schemeProvider = schemeProvider
    }

    // MARK: - Body
    
    public var body: some View {
        let scheme = schemeProvider.scheme
        VStack(alignment: .leading, spacing: 8.0) {
            if title != nil {
                titleView(scheme: scheme)
            }
            if tagSubtitle != nil || tagText != nil {
                tagSubtitleView(scheme: scheme)
            }
            if subtitle != nil {
                subtitleView(scheme: scheme)
            }
            if buttonTitle != nil {
                buttonView(scheme: scheme)
            }
        }
    }
    
    // MARK: - Private Methods
    
    private func titleView(scheme: TitleSubtitleButtonListViewScheme) -> some View {
        return Text(title ?? "")
            .multilineTextAlignment(.leading)
            .font(scheme.titleFont.swiftUIFont)
            .foregroundColor(isEnabled ? scheme.titleLabelTextColor.parameter(for: .normal)?.swiftUIColor : scheme.titleLabelTextColor.parameter(for: .disabled)?.swiftUIColor)
    }
    
    private func tagSubtitleView(scheme: TitleSubtitleButtonListViewScheme) -> some View {
        return HStack(alignment: .center, spacing: 4.0, content: {
            if let tagSubtitle = tagSubtitle {
                Text(tagSubtitle)
                    .multilineTextAlignment(.leading)
                    .font(scheme.subtitleTagFont.swiftUIFont)
                    .foregroundColor(isEnabled ? scheme.subtitleLabelTextColor.parameter(for: .normal)?.swiftUIColor : scheme.subtitleLabelTextColor.parameter(for: .disabled)?.swiftUIColor)
            }
            if let tagText = tagText {
                Text(tagText)
                    .padding(LayoutGrid.halfModule)
                    .background(scheme.tagViewBackgroundColor.parameter(for: .normal)?.swiftUIColor)
                    .clipShape(
                        RoundedCorner(radius: 4.0, corners: [.allCorners])
                    )
                    .foregroundColor(isEnabled ? scheme.subtitleTagLabelTextColor.parameter(for: .normal)?.swiftUIColor : scheme.subtitleTagLabelTextColor.parameter(for: .disabled)?.swiftUIColor)
                    .font(scheme.tagViewFont.swiftUIFont)
            }
            Spacer()
        })
    }
    
    private func subtitleView(scheme: TitleSubtitleButtonListViewScheme) -> some View {
        return Text(subtitle ?? "")
            .multilineTextAlignment(.leading)
            .lineLimit(subtitleLineLimit)
            .font(scheme.subtitleFont.swiftUIFont)
            .foregroundColor(isEnabled ? scheme.subtitleLabelTextColor.parameter(for: .normal)?.swiftUIColor : scheme.subtitleLabelTextColor.parameter(for: .disabled)?.swiftUIColor)
    }
    
    private func buttonView(scheme: TitleSubtitleButtonListViewScheme) -> some View {
        return Button(action: buttonAction, label: {
            Text(buttonTitle ?? "")
                .multilineTextAlignment(.leading)
                .font(scheme.ghostButtonFont.swiftUIFont)
                .foregroundColor(isEnabled ? scheme.buttonTitleColor.parameter(for: .normal)?.swiftUIColor : scheme.buttonTitleColor.parameter(for: .disabled)?.swiftUIColor)
        })
    }
    
}

@available(iOS 14.0, *)
struct TitleSubtitleButtonListView_Previews: PreviewProvider {

    static var previews: some View {
        TitleSubtitleButtonListView(
            title: "title",
            tagSubtitle: "tagSubtitle",
            tagText: "tagText",
            subtitle: "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo",
            subtitleLineLimit: 3,
            buttonTitle: "button",
            buttonAction: nil
        )
    }

}

