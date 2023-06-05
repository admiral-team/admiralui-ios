//
//  TitleListView.swift
//  AdmiralSwiftUI
//
//  Created on 07.06.2021.
//

import SwiftUI
import AdmiralTheme

/**
 TitleListViewStyle - Public enum for TitleListView
 
 TitleListViewStyle can be one of the following values:
 - title
 - body
 - headline
 - headlineSecondary
 - paragraph
 - paragraphSecondary
 */
public enum TitleListViewStyle: String {
    case title
    case body
    case headline
    case headlineSecondary
    case paragraph
    case paragraphSecondary
}

/**
 TitleListView - A view object with card image view.
 
 You can create a TitleListView with the zero frame rectangle by specifying the following parameters in init:

 - title: String? - The text that the label displays.
 - textAligment: TextAlignment - Aligns the child view within its bounds given anchor types.
 - lineLimit: Int? -  Line limit of title text
 - titleListViewStyle: TitleListViewStyle? - A style for display text of TitleListView
 
 ## Example to create TitleListView
 # Code
 ```
 TitleListView(
     title: "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.",
     textAligment: .center,
     lineLimit: 3
 )
```
 */
/// A view object with title.
@available(iOS 14.0.0, *)
public struct TitleListView: View, CenterListViewComponent {
    
    @State public var isHighlighted: Bool = false
    @State public var isHighlightedEnabled: Bool = true
    
    /// The text that the label displays.
    @Binding public var title: String?
    
    // MARK: Internal Properties
    
    @Environment(\.isEnabled) var isEnabled
    
    /// The state of the view. Default is normal.
    @State var state: ControlState = .normal
    
    var titleListViewStyle: TitleListViewStyle?
    var textAligment: TextAlignment = .leading
    
    // MARK: - Private Properties

    /// Linelimit of title text
    private let lineLimit: Int?

    @ObservedObject private var schemeProvider: SchemeProvider<TitleListViewScheme>
    
    // MARK: - Initializer
    
    /// Initializes and returns a newly allocated view object with the zero frame rectangle.
    public init(
        title: String?,
        textAligment: TextAlignment = .leading,
        lineLimit: Int? = nil,
        titleListViewStyle: TitleListViewStyle? = nil,
        schemeProvider: SchemeProvider<TitleListViewScheme> = AppThemeSchemeProvider<TitleListViewScheme>()
    ) {
        self._title = Binding(get: { return title }, set: { _ in })
        self.lineLimit = lineLimit
        self.textAligment = textAligment
        self.titleListViewStyle = titleListViewStyle
        self.schemeProvider = schemeProvider
    }

    // MARK: - Layout
    public var body: some View {
        let scheme = schemeProvider.scheme
        let textColor = scheme.textColor.parameter(for: isEnabled ? .normal : .disabled, style: titleListViewStyle)
        switch textAligment {
        case .leading:
            return HStack(spacing: .zero) {
                textView(textColor: textColor, scheme: scheme)
                Spacer(minLength: 0.0)
            }
            .eraseToAnyView()
        case .trailing:
            return HStack(spacing: .zero) {
                Spacer(minLength: 0.0)
                textView(textColor: textColor, scheme: scheme)
            }
            .eraseToAnyView()
        case .center:
            return textView(textColor: textColor, scheme: scheme)
                .eraseToAnyView()
        }
    }

    // MARK: - Private Methods

    private func textView(textColor: AColor?, scheme: TitleListViewScheme) -> some View {
        Text(title ?? "")
            .foregroundColor(textColor?.swiftUIColor)
            .font(scheme.titleFont.parameter(for: .normal, style: titleListViewStyle)?.swiftUIFont)
            .multilineTextAlignment(textAligment)
            .lineLimit(lineLimit)
            .fixedSize(horizontal: false, vertical: true)
    }
    
}


@available(iOS 14.0, *)
struct TitleListView_Previews: PreviewProvider {

    static var previews: some View {
        TitleListView(
            title: "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.",
            textAligment: .center,
            lineLimit: 3
        )
    }

}



