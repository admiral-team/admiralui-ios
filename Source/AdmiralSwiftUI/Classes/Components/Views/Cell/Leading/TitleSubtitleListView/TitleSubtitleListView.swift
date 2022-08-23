//
//  TitleSubtitleListView.swift
//  AdmiralSwiftUI
//
//  Created on 07.06.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources

/**
 TitleSubtitleListViewStyle - Public enum for TitleSubtitleListView.
 
 TitleSubtitleListViewStyle can be one of the following values:
 - title
 - body
 - headline
 - headlineSecondary
 */
public enum TitleSubtitleListViewStyle: String {
    case title
    case body
    case headline
    case headlineSecondary
}

/**
 TitleSubtitleListView - A view object with card image view.
 
 You can create a TitleSubtitleListView with the zero frame rectangle by specifying the following parameters in init:

 - title: String? - The text that the label displays.
 - subtitle: String? - The text that the subtitle label displays.
 - textAligment: TextAlignment - Aligns the child view within its bounds given anchor types.
 - lineLimit: Int? -  Line limit of title text
 - titleListViewStyle: TitleSubtitleListViewStyle? - A style for display text of TitleSubtitleListView
 
 ## Example to create TitleSubtitleListView
 # Code
 ```
 static var previews: some View {
     TitleSubtitleListView(
                    title: "title",
                    subtitle: "First text",
                    lineLimit: 1)
 
     TitleSubtitleListView(
                    title: "title",
                    subtitle: "Second text")
    }
 )
```
 */
/// A view object with title and subtitle.
@available(iOS 14.0.0, *)
public struct TitleSubtitleListView: View, LeadingListViewComponent {
    
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

    @Binding private var scheme: TitleSubtitleListViewScheme?
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<TitleSubtitleListViewScheme>()

    // MARK: - Initializer
    
    /// Initializes and returns a newly allocated view object with the zero frame rectangle.
    public init(
        title: String?,
        subtitle: String?,
        lineLimit: Int? = nil,
        titleSubtitleListViewStyle: TitleSubtitleListViewStyle? = nil,
        scheme: Binding<TitleSubtitleListViewScheme?> = .constant(nil)
    ) {
        self._title = Binding(get: { return title }, set: { _ in })
        self._subtitle = Binding(get: { return subtitle }, set: { _ in })
        self.lineLimit = lineLimit
        self.titleSubtitleListViewStyle = titleSubtitleListViewStyle
        self._scheme = scheme
    }
    
    // MARK: - Layout
    
    public var body: some View {
        let scheme = self.scheme ?? schemeProvider.scheme
        HStack(spacing: 0.0) {
            VStack(alignment: .leading, spacing: 4.0) {
                if let title = title {
                    Text(title)
                        .font(scheme.titleFont.parameter(for: .normal, style: titleSubtitleListViewStyle)?.swiftUIFont)
                        .foregroundColor(isEnabled ? scheme.titleColor.parameter(for: .normal)?.swiftUIColor : scheme.titleColor.parameter(for: .disabled)?.swiftUIColor)
                }
                if let subtitle = subtitle {
                    Text(subtitle)
                        .font(scheme.subtitleFont.parameter(for: .normal, style: titleSubtitleListViewStyle)?.swiftUIFont)
                        .lineLimit(lineLimit)
                        .foregroundColor(isEnabled ? scheme.subtitleColor.parameter(for: .normal)?.swiftUIColor : scheme.subtitleColor.parameter(for: .disabled)?.swiftUIColor)
                }
                
            }
            .multilineTextAlignment(.leading)
            Spacer(minLength: 0.0)
        }
    }
    
    // MARK: - Internal Methods
    
    func scheme(_ scheme: Binding<TitleSubtitleListViewScheme?>) -> some View {
        var view = self
        view._scheme = scheme
        return view.id(UUID())
    }
    
}

@available(iOS 14.0, *)
struct TitleSubtitleListView_Previews: PreviewProvider {

    static var previews: some View {
        TitleSubtitleListView(title: "title", subtitle: "At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga. Et harum quidem rerum facilis est et expedita distinctio", lineLimit: 1)
        TitleSubtitleListView(title: "title", subtitle: "At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga. Et harum quidem rerum facilis est et expedita distinctio")
    }

}
