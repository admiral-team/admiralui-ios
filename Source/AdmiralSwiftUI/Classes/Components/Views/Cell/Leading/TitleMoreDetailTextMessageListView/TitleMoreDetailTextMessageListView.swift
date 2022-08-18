//
//  TitleMoreDetailTextMessageListView.swift
//  AdmiralSwiftUI
//
//  Created on 07.06.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources

/**
 TitleMoreDetailTextMessageListView - A view object with title, more label, detaile label and message view.
 
 You can create a TitleMoreDetailTextMessageListView with the zero frame rectangle by specifying the following parameters in init:

 - title: String? - The text that the title label displays.
 - more: String? - The text that the more label displays.
 - detaile: String? - The text that the detaile label displays.
 - detaileMore: String? - The text that the detaile more label displays.
 - subtitle: String? - The text that the subtitle label displays.
 - tagText: String? - The text that the tag view displays.
 - messageText: String? - The text that the message label displays.
 - infoImage: Image? - The info image
 
 ## Example to create TitleMoreDetailTextMessageListView
 # Code
 ```
 TitleMoreDetailTextMessageListView(
     title: "Title",
     more: "More",
     detaile: "Detail",
     detaileMore: "More",
     subtitle: "Subtitle",
     tagText: "Percent",
     messageText: "Text message",
     infoImage: Image("Your image")
 )
```
 */
/// A view object with title, more label, detaile label and message view.
@available(iOS 14.0.0, *)
public struct TitleMoreDetailTextMessageListView: View, LeadingListViewComponent {
    
    private enum Constants {
        static let verticalPadding: CGFloat = 6.0
    }
    
    // MARK: - Public Properties
    
    public var isHighlighted: Bool = false
    
    public var isHighlightedEnabled: Bool = true
    
    /// The text that the title label displays.
    @Binding public var title: String?
    
    /// The text that the more label displays.
    @Binding public var more: String?
    
    /// The text that the detaile label displays.
    @Binding public var detaile: String?
    
    /// The text that the detaile more label displays.
    @Binding public var detaileMore: String?

    /// The text that the subtitle label displays.
    @Binding public var subtitle: String?
    
    /// The text that the tag view displays.
    @Binding public var tagText: String?
    
    /// The text that the message label displays.
    @Binding public var messageText: String?
    
    /// The info image.
    @Binding public var infoImage: Image?
    
    // MARK: Internal Properties
    
    @Environment(\.isEnabled) var isEnabled
    
    @State private var scheme: TitleMoreDetailTextMessageListViewScheme? = nil
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<TitleMoreDetailTextMessageListViewScheme>()
    
    // MARK: - Initializer
    
    /// Initializes and returns a newly allocated view object with the zero frame rectangle.
    public init(
        title: String? = nil,
        more: String? = nil,
        detaile: String? = nil,
        detaileMore: String? = nil,
        subtitle: String? = nil,
        tagText: String? = nil,
        messageText: String? = nil,
        infoImage: Image? = nil,
        scheme: TitleMoreDetailTextMessageListViewScheme? = nil
    ) {
        self._title = Binding(get: { return title }, set: { _ in })
        self._more = Binding(get: { return more }, set: { _ in })
        self._detaile = Binding(get: { return detaile }, set: { _ in })
        self._detaileMore = Binding(get: { return detaileMore }, set: { _ in })
        self._subtitle = Binding(get: { return subtitle }, set: { _ in })
        self._tagText = Binding(get: { return tagText }, set: { _ in })
        self._messageText = Binding(get: { return messageText }, set: { _ in })
        self._infoImage = Binding(get: { return infoImage }, set: { _ in })
        self.scheme = scheme
    }

    // MARK: - Body

    public var body: some View {
        let scheme = self.scheme ?? schemeProvider.scheme
        VStack(alignment: .leading, spacing: LayoutGrid.module) {
            if title != nil || more != nil {
                titleMoreView(scheme: scheme)
            }
            if detaile != nil || detaileMore != nil {
                detaileMoreView(scheme: scheme)
            }
            if subtitle != nil || tagText != nil {
                subtitleTagTextView(scheme: scheme)
            }
            if messageText != nil {
                textMessageView(scheme: scheme)
            }
        }
    }
    
    // MARK: - Internal Methods
    
    func scheme(_ scheme: TitleMoreDetailTextMessageListViewScheme) -> some View {
        var view = self
        view._scheme = State(initialValue: scheme)
        return view.id(UUID())
    }
    
    // MARK: - Private Methods
    
    private func titleMoreView(scheme: TitleMoreDetailTextMessageListViewScheme) -> some View {
        return HStack(alignment: .center, spacing: LayoutGrid.halfModule, content: {
            if let title = title {
                Text(title)
                    .multilineTextAlignment(.leading)
                    .font(scheme.titleFont.swiftUIFont)
                    .foregroundColor(isEnabled ? scheme.titleLabelTextColor.parameter(for: .normal)?.swiftUIColor : scheme.titleLabelTextColor.parameter(for: .disabled)?.swiftUIColor)
            }
            if let more = more {
                Text(more)
                    .multilineTextAlignment(.leading)
                    .offset(y: 1.0)
                    .font(scheme.moreFont.swiftUIFont)
                    .foregroundColor(isEnabled ? scheme.moreLabelTextColor.parameter(for: .normal)?.swiftUIColor : scheme.moreLabelTextColor.parameter(for: .disabled)?.swiftUIColor)
            }
        })
    }
    
    private func detaileMoreView(scheme: TitleMoreDetailTextMessageListViewScheme) -> some View {
        return HStack(alignment: .center, spacing: LayoutGrid.halfModule, content: {
            if let detaile = detaile {
                Text(detaile)
                    .multilineTextAlignment(.leading)
                    .font(scheme.detaileTitleFont.swiftUIFont)
                    .foregroundColor(isEnabled ? scheme.detaileTitleLabelTextColor.parameter(for: .normal)?.swiftUIColor : scheme.detaileTitleLabelTextColor.parameter(for: .disabled)?.swiftUIColor)
            }
            if let detaileMore = detaileMore {
                Text(detaileMore)
                    .multilineTextAlignment(.leading)
                    .font(scheme.detaileMoreFont.swiftUIFont)
                    .foregroundColor(isEnabled ? scheme.detaileMoreLabelTextColor.parameter(for: .normal)?.swiftUIColor : scheme.detaileMoreLabelTextColor.parameter(for: .disabled)?.swiftUIColor)
            }
            if let infoImage = infoImage {
                infoImage
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: LayoutGrid.halfModule * 3, height: LayoutGrid.halfModule * 3)
                    .foregroundColor(isEnabled ? scheme.infoImageViewTintColor.parameter(for: .normal)?.swiftUIColor : scheme.infoImageViewTintColor.parameter(for: .disabled)?.swiftUIColor)
            }
        })
    }
    
    private func subtitleTagTextView(scheme: TitleMoreDetailTextMessageListViewScheme) -> some View {
        return HStack(alignment: .center, spacing: LayoutGrid.module, content: {
            if let subtitle = subtitle {
                Text(subtitle)
                    .multilineTextAlignment(.leading)
                    .font(scheme.subtitleFont.swiftUIFont)
                    .foregroundColor(isEnabled ? scheme.subtitleLabelTextColor.parameter(for: .normal)?.swiftUIColor : scheme.subtitleLabelTextColor.parameter(for: .disabled)?.swiftUIColor)
            }
            if let tagText = tagText {
                Text(tagText)
                    .font(scheme.tagViewFont.swiftUIFont)
                    .foregroundColor(isEnabled ? scheme.infoImageViewTintColor.parameter(for: .normal)?.swiftUIColor : scheme.infoImageViewTintColor.parameter(for: .disabled)?.swiftUIColor)
                    .padding(LayoutGrid.halfModule)
                    .background(
                        isEnabled ? scheme.messageViewBackgroundColor.parameter(for: .normal)?.swiftUIColor : scheme.messageViewBackgroundColor.parameter(for: .disabled)?.swiftUIColor)
                    .cornerRadius(LayoutGrid.halfModule)
            }
        })
    }
    
    private func textMessageView(scheme: TitleMoreDetailTextMessageListViewScheme) -> some View {
        return Text(messageText ?? "")
            .font(scheme.messageTitleFont.swiftUIFont)
            .foregroundColor(isEnabled ? scheme.messageTitleLabelTitleColor.parameter(for: .normal)?.swiftUIColor : scheme.messageTitleLabelTitleColor.parameter(for: .disabled)?.swiftUIColor)
            .padding(.leading, LayoutGrid.doubleModule)
            .padding(.trailing, LayoutGrid.doubleModule)
            .padding(.top, Constants.verticalPadding)
            .padding(.bottom, Constants.verticalPadding)
            .background(isEnabled ? scheme.messageViewBackgroundColor.parameter(for: .normal)?.swiftUIColor : scheme.messageViewBackgroundColor.parameter(for: .disabled)?.swiftUIColor)
            .clipShape(
                RoundedCorner(radius: LayoutGrid.module, corners: [.bottomLeft])
            )
            .clipShape(
                RoundedCorner(radius: LayoutGrid.doubleModule, corners: [.bottomRight, .topRight])
            )
    }
    
}

