//
//  BadgeArrowListView.swift
//  AdmiralUIResources
//
//  Created by Ivon Evgeniy on 18.11.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources

/**
 BadgeArrowListView - A view object with big title.
 
 You can create a ImageListView with a zero-frame rectangle using one of the two initializers.

 First init:
 - badgeStyle: Badge style.
 - value: Text on badge.
 
 Second init:
 - badgeStyle: Badge style.
 - text: Text on badge.
 
 ## Example to create BadgeArrowListView
 # Code
 ```
 BadgeArrowListView(
            badgeStyle: .default,
            text: "Text")
```
 */
/// A view object with badge and arrow image view.
@available(iOS 14.0.0, *)
public struct BadgeArrowListView: View, TralingListViewComponent {

    // MARK: - Constants

    private enum Constants {
        static let cellWidth: CGFloat = LayoutGrid.halfModule * 6
        static let cellHeightThreshold: CGFloat = LayoutGrid.halfModule * 18
        static let cellItemsSpacing: CGFloat = LayoutGrid.halfModule
    }

    // MARK: - Public Properties
    
    @State public var isHighlighted: Bool = false
    @State public var isHighlightedEnabled: Bool = true

    // MARK: - Internal Properties
    
    @Environment(\.isEnabled) var isEnabled
    
    var text: String?
    var value: Int?
    var badgeStyle: BadgeStyle

    // MARK: - Private Properties
    
    @State private var scheme: BadgeArrowListViewScheme? = nil
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<BadgeArrowListViewScheme>()
    
    @State private var viewSize: CGSize = .zero

    private var alignment: VerticalAlignment {
        viewSize.height > Constants.cellHeightThreshold ? .top : .center
    }

    // MARK: - Initializer
    
    /// Initializes and returns a newly allocated view object with the zero frame rectangle.
    /// - Parameters:
    ///   - badgeStyle: Badge style.
    ///   - value: Text on badge.
    public init(
        badgeStyle: BadgeStyle,
        value: Int?,
        scheme: BadgeArrowListViewScheme? = nil
    ) {
        self.badgeStyle = badgeStyle
        self.value = value
        self.scheme = scheme
    }
    
    /// Initializes and returns a newly allocated view object with the zero frame rectangle.
    /// - Parameters:
    ///   - badgeStyle: Badge style.
    ///   - text: Text on badge.
    public init(
        badgeStyle: BadgeStyle,
        text: String?,
        scheme: BadgeArrowListViewScheme? = nil
    ) {
        self.badgeStyle = badgeStyle
        self.text = text
        self.scheme = scheme
    }

    // MARK: - Body

    public var body: some View {
        let scheme = self.scheme ?? schemeProvider.scheme
        HStack(spacing: Constants.cellItemsSpacing) {
            Spacer()
            BadgeView(badgeStyle: badgeStyle, text: textForBadge())
                .scheme(scheme.badgeViewScheme)
                .fixedSize()
            Image(uiImage: AdmiralUIResources.PrivateAsset.Custom.Cell.arrow.image)
                .frame(width: LayoutGrid.module, height: LayoutGrid.doubleModule)
                .foregroundColor(scheme.arrowListViewScheme.imageTintColor.parameter(for: isEnabled ? .normal : .disabled)?.swiftUIColor)
        }
    }
    
    // MARK: - Internal Methods
    
    func scheme(_ scheme: BadgeArrowListViewScheme) -> some View {
        var view = self
        view._scheme = State(initialValue: scheme)
        return view.id(UUID())
    }
    
    func textForBadge() -> String? {
        var resultText: String?
        if let value = value {
            resultText = "\(value)"
        } else if let text = text {
            resultText = text
        }
        return resultText
    }

}
