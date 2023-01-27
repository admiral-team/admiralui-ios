//
//  BigInformer.swift
//  AdmiralUIResources
//
//  Created on 18.05.2021.
//

import AdmiralTheme
import SwiftUI

/// The style of informer.
public enum InformerStyleSwiftUI: Int {
    /// The default state of the informer.
    case `default`
    /// The success state of the informer.
    case success
    /// The attention state of the informer.
    case attention
    /// The error state of the informer is useful to show the number of errors.
    case error
}

/**
 BigInformer - The component is in four status colors, does not have a Pop-up. It consists of several elements that can be disabled in layers. Adapts to the width of the device screen. The maximum height of the component is 400 px.

 You can create a BigInformer with the zero frame rectangle by specifying the following parameters in init:

 - title: String? - Informer title text.
 - subtitle: String? - Informer subtitle text.
 - link: String? - Informer link text.
 - informerStyle: InformerStyleSwiftUI - The style of Informer.
 - onDetail: (() -> Void)? - The callback action by tapping the link
 
 ## Example to create BigInformer
 # Code
 ```
 SmallInformer(
     title: .constant("Text"),
     informerStyle: .default,
     arrowDirection: .top)
```
 */
@available(iOS 14.0, *)
public struct BigInformer: View {

    // MARK: - Constants

    private enum Constants {
        static let cornerRadius: CGFloat = LayoutGrid.halfModule * 3
        static let labelWidth: CGFloat = UIScreen.main.bounds.width - LayoutGrid.quadrupleModule
        static let labelEdgeInsets: EdgeInsets = EdgeInsets(
            top: 0.0,
            leading: LayoutGrid.doubleModule,
            bottom: 0.0,
            trailing: LayoutGrid.doubleModule
        )
    }
    
    // MARK: - Internal Properties
    
    @Environment(\.isEnabled) private var isEnabled
    
    // MARK: - Private Properties

    
    private var title: String?
    private var subtitle: String?
    private var link: String?
    private var informerStyle: InformerStyleSwiftUI = .default
    private var linkAccessibilityID: String
    private let onDetail: (() -> Void)?
    
    @ObservedObject private var schemeProvider: SchemeProvider<BigInformerScheme>
    
    // MARK: - Initializer
    
    /// Initializes and returns a newly allocated input number object.
    /// - Parameters:
    ///   - title: Informer title text
    ///   - subtitle: Informer subtitle text
    ///   - link: Informer link text
    ///   - informerStyle: The style of Informer,
    ///   - onDetail: The callback action by tapping the link
    public init(
        title: String? = nil,
        subtitle: String? = nil,
        link: String? = nil,
        informerStyle: InformerStyleSwiftUI = .default,
        linkAccessibilityID: String = "",
        schemeProvider: SchemeProvider<BigInformerScheme> = AppThemeSchemeProvider<BigInformerScheme>(),
        onDetail: (() -> Void)? = nil
    ) {
        self.title = title
        self.subtitle = subtitle
        self.link = link
        self.informerStyle = informerStyle
        self.linkAccessibilityID = linkAccessibilityID
        self.schemeProvider = schemeProvider
        self.onDetail = onDetail
    }

    // MARK: - Body

    public var body: some View {
        let scheme = schemeProvider.scheme
        let titleFont = Font(scheme.titleLabelFont.uiFont)
        let titleColor = Color(
            scheme.titleLabelTextColors.parameter(
            isEnabled: isEnabled,
                style: informerStyle)?.uiColor ?? .clear)

        let subtitleFont = Font(scheme.subtitleLabelFont.uiFont)
        let subtitleColor = Color(
            scheme.subtitleLabelTextColors.parameter(
            isEnabled: isEnabled,
                style: informerStyle)?.uiColor ?? .clear)

        let linkFont = Font(scheme.linkLabelFont.uiFont)
        let linkColor = Color(
            scheme.linkLabelTextColors.parameter(
            isEnabled: isEnabled,
                style: informerStyle)?.uiColor ?? .clear)

        let wrapViewColor = Color(
            scheme.wrapViewBackgroundColors.parameter(
            isEnabled: isEnabled,
                style: informerStyle)?.uiColor ?? .clear)

        VStack {
            Spacer().frame(height: LayoutGrid.halfModule * 5)
            if let title = title {
                HStack {
                Text(title)
                    .foregroundColor(titleColor)
                    .font(titleFont)
                    .lineLimit(1)
                    .padding(Constants.labelEdgeInsets)
                }.frame(
                    width: Constants.labelWidth,
                    alignment: .leading)
            }
            if let subtitle = subtitle {
                Spacer().frame(height: title == nil ? 0 : LayoutGrid.module)
                HStack {
                Text(subtitle)
                    .foregroundColor(subtitleColor)
                    .font(subtitleFont)
                    .lineLimit(8)
                    .padding(Constants.labelEdgeInsets)
                }.frame(
                    width: Constants.labelWidth,
                    alignment: .leading)
            }
            if let link = link {
                let spacerHeight: CGFloat = (title == nil && subtitle == nil) ? 0 : LayoutGrid.doubleModule
                Spacer().frame(height: spacerHeight)
                HStack {
                Text(link)
                    .foregroundColor(linkColor)
                    .font(linkFont)
                    .lineLimit(1)
                    .padding(Constants.labelEdgeInsets)
                    .accessibilityElement()
                    .accessibility(addTraits: .isButton)
                    .accessibility(identifier: linkAccessibilityID)
                    .onTapGesture {
                        guard let onDetail = onDetail else { return }
                        onDetail()
                    }
                }.frame(
                    width: Constants.labelWidth,
                    alignment: .leading)
            }
            Spacer().frame(height: LayoutGrid.halfModule * 5)
        }
        .background(wrapViewColor)
        .clipShape(RoundedRectangle(cornerRadius: Constants.cornerRadius))
        .padding(Constants.labelEdgeInsets)
    }
    
}
