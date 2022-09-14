//
//  BadgeView.swift
//  AdmiralSwiftUI
//
//  Created on 06.08.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources
/**
 BadgeStyle - Public enum for style BadgeView

 BadgeStyle can be one of the following values:
 - natural - The natural state of the badge
 - default - The default state of the badge
 - additional - The additional state of the badge
 - success - The success state of the badge
 - error - The error state of the badge is useful to show the number of errors
 - attention - The attention state of the badge is useful to show the number of attentions
 */
/// The style of badge.
public enum BadgeStyle: Int {
    /// The natural state of the badge
    case natural
    /// The default state of the badge
    case `default`
    /// The additional state of the badge
    case additional
    /// The success state of the badge
    case success
    /// The error state of the badge is useful to show the number of errors
    case error
    /// The attention state of the badge is useful to show the number of attentions
    case attention
}

/**
 BadgeView - The Badge component shows a quantitative value, usually complements other components, for example, to show the number of alerts in the Bottom navigation or Toolbar section
 You can create a BadgeView by specifying the following parameters in the initializer
 ## Initializer parameters:
 - value: Int? - Integer value of the badge.
 - text: String? - Text value of the badge.
 - badgeStyle: BadgeStyle - Badge style to configure the badge with library styles or custom style.
 - content: () -> (Content) - Сlosure returning a new view containing content.
 - borderColor: Color? - Border color. Default from color style.
 - offset: CGPoint? - Badge offset. Default is zero.
 ## Example to create BadgeView:
 # Code
 ```
 BadgeView(
 badgeStyle: .default,
 value: 1,
 content: {
 Image("Your image")
 .resizable()
 .aspectRatio(contentMode: .fit)
 .frame(width: 50.0, height: 50.0, alignment: .center)
 })
 ```
 */
@available(iOS 14.0, *)
public struct BadgeView<Content>: View where Content: View {

    // MARK: - Public Properties

    /// Integer value of the badge.
    private var value: Int?

    /// Text value of the badge.
    private var text: String?

    /// Badge style to configure the badge with library styles or custom style.
    private let badgeStyle: BadgeStyle

    /// Content.
    private var content: (() -> (Content))?

    /// Border color. Default from color style.
    private let borderColor: Color?

    /// Badge offset.
    private let offset: CGPoint

    // MARK: - Internal Properties

    @Environment(\.isEnabled) var isEnabled

    // MARK: - Private Properties

    @State private var segmentSize: CGSize = .zero

    @ObservedObject private var schemeProvider: SchemeProvider<BadgeViewScheme>

    // MARK: - Initializer

    /// Initializes and returns a newly allocated view object with the zero frame rectangle.
    /// - Parameters:
    ///   - badgeStyle: Badge style.
    ///   - value: Value for badge label.
    ///   - borderColor: Border color.
    ///   - offset: Offset badge.
    ///   - content: Content.
    public init(
        badgeStyle: BadgeStyle,
        value: Int?,
        borderColor: Color? = nil,
        offset: CGPoint = .zero,
        @ViewBuilder content: @escaping () -> (Content),
        schemeProvider: SchemeProvider<BadgeViewScheme> = AppThemeSchemeProvider<BadgeViewScheme>()
    ) {
        self.badgeStyle = badgeStyle
        self.value = value
        self.borderColor = borderColor
        self.offset = offset
        self.content = content
        self.schemeProvider = schemeProvider
    }

    /// Initializes and returns a newly allocated view object with the zero frame rectangle.
    /// - Parameters:
    ///   - badgeStyle: Badge style.
    ///   - text: Text for badge label.
    ///   - borderColor: Border color.
    ///   - offset: Offset badge.
    ///   - content: Content.
    public init(
        badgeStyle: BadgeStyle,
        text: String?,
        borderColor: Color? = nil,
        offset: CGPoint = .zero,
        @ViewBuilder content: @escaping () -> (Content),
        schemeProvider: SchemeProvider<BadgeViewScheme> = AppThemeSchemeProvider<BadgeViewScheme>()
    ) {
        self.badgeStyle = badgeStyle
        self.text = text
        self.borderColor = borderColor
        self.content = content
        self.offset = offset
        self.schemeProvider = schemeProvider
    }

    // MARK: - Body

    public var body: some View {
        if let content = content {
            ZStack(alignment: .topTrailing) {
                content()
                badgeView()
            }
        } else {
            badgeView()
        }
    }

    // MARK: - Internal Methods

    func scheme(_ scheme: BadgeViewScheme) -> some View {
        var view = self
        view.schemeProvider = SchemeProvider.constant(scheme: scheme)
        return view.id(UUID())
    }

    @ViewBuilder
    func badgeView() -> some View {
        let scheme = schemeProvider.scheme
        let badgeForegroundColor = scheme.backgroundColor.parameter(for: isEnabled  ? .normal : .disabled, style: badgeStyle)?.swiftUIColor
        let strokeColor = borderColor ?? scheme.borderColor.swiftUIColor

        if let text = textForTextView() {
            if content != nil {
                textView(text, scheme: scheme)
                    .modifier(SizeAwareViewModifier(viewSize: $segmentSize))
                    .offset(x: max(segmentSize.width - LayoutGrid.halfModule * 5 + offset.x, offset.y))
            } else {
                textView(text, scheme: scheme)
                    .offset(x: offset.x, y: offset.y)
            }
        } else {
            Rectangle()
                .frame(width: LayoutGrid.module, height: LayoutGrid.module)
                .foregroundColor(badgeForegroundColor)
                .cornerRadius(LayoutGrid.halfModule)
                .overlay(RoundedRectangle(cornerRadius: LayoutGrid.halfModule)
                    .stroke(strokeColor, lineWidth: LayoutGrid.halfModule / 2))
                .offset(x: offset.x, y: offset.y)
        }
    }

    func textForTextView() -> String? {
        var resultText: String?
        if let value = value {
            resultText = "\(value)"
        } else if let text = text {
            resultText = text
        }
        return resultText
    }

    func textView(_ text: String, scheme: BadgeViewScheme) -> some View {
        let badgeForegroundColor = scheme.backgroundColor.parameter(for: isEnabled  ? .normal : .disabled, style: badgeStyle)?.swiftUIColor
        let strokeColor = borderColor ?? scheme.borderColor.swiftUIColor
        let textColor = scheme.textColor.parameter(for: isEnabled ? .normal : .disabled, style: badgeStyle)?.swiftUIColor
        return Text(text)
            .font(scheme.font.swiftUIFont)
            .foregroundColor(textColor)
            .padding(.horizontal, LayoutGrid.module)
            .padding(.vertical, LayoutGrid.halfModule / 2)
            .frame(minWidth: LayoutGrid.halfModule * 5, minHeight: LayoutGrid.halfModule * 5)
            .overlay(RoundedRectangle(cornerRadius: LayoutGrid.halfModule * 5)
                .stroke(strokeColor, lineWidth: LayoutGrid.halfModule / 2))
            .background(
                RoundedRectangle(cornerRadius: LayoutGrid.halfModule * 5)
                    .foregroundColor(badgeForegroundColor)
            )
    }

}

@available(iOS 14.0, *)
extension BadgeView where Content == EmptyView {

    /// Initializes and returns a newly allocated view object with the zero frame rectangle.
    /// - Parameters:
    ///   - badgeStyle: Badge style.
    ///   - value: Value for badge label.
    ///   - borderColor: Border color.
    ///   - offset: Offset badge.
    public init(
        badgeStyle: BadgeStyle,
        value: Int?,
        borderColor: Color? = nil,
        offset: CGPoint = .zero,
        schemeProvider: SchemeProvider<BadgeViewScheme> = AppThemeSchemeProvider<BadgeViewScheme>()
    ) {
        self.badgeStyle = badgeStyle
        self.value = value
        self.borderColor = borderColor
        self.offset = offset
        self.schemeProvider = schemeProvider
    }

    /// Initializes and returns a newly allocated view object with the zero frame rectangle.
    /// - Parameters:
    ///   - badgeStyle: Badge style.
    ///   - text: Text for badge label.
    ///   - borderColor: Border color.
    ///   - offset: Offset badge.
    public init(
        badgeStyle: BadgeStyle,
        text: String?,
        borderColor: Color? = nil,
        offset: CGPoint = .zero,
        schemeProvider: SchemeProvider<BadgeViewScheme> = AppThemeSchemeProvider<BadgeViewScheme>()
    ) {
        self.badgeStyle = badgeStyle
        self.text = text
        self.borderColor = borderColor
        self.offset = offset
        self.schemeProvider = schemeProvider
    }
}

@available(iOS 14.0, *)
struct BadgeView_Previews: PreviewProvider {

    static var previews: some View {
        BadgeView(
            badgeStyle: .default,
            value: 1,
            content: {
                AssetSymbol.Category.Outline.acuringFuture.image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50.0, height: 50.0, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            })
    }
}
