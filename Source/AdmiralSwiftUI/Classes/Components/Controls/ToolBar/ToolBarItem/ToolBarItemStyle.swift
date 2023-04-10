//
//  ToolBarItemStyle.swift
//  AdmiralSwiftUI
//
//  Created on 31.05.2021.
//

import AdmiralCore
import AdmiralTheme
import AdmiralUIResources
import SwiftUI

@available(iOS 14.0.0, *)
public struct ToolBarItemStyle: ButtonStyle {

    // MARK: - Properties

    /// The image
    public var image: Image

    /// The title
    public var title: String

    /// The badge style
    public var badgeStyle: ToolBarBadgeStyle?

    /// The type that can be horizontal or vertical
    public var type: ToolBarType

    /// The visual scheme
    public var scheme: ToolBarItemScheme

    /// A Boolean value that indicates whether the view is enabled
    public var isSelected: Bool

    /// The value that controls an image color and title color
    public var itemType: ToolbarItemType

    /// A Boolean value that indicates whether the view is enabled
    public var isEnabled: Bool

    // MARK: - Initializer

    public init(
        scheme: ToolBarItemScheme,
        image: Image,
        title: String,
        badgeStyle: ToolBarBadgeStyle?,
        type: ToolBarType,
        itemType: ToolbarItemType,
        isSelected: Bool,
        isEnabled: Bool
    ) {
        self.scheme = scheme
        self.image = image
        self.title = title
        self.badgeStyle = badgeStyle
        self.type = type
        self.itemType = itemType
        self.isSelected = isSelected
        self.isEnabled = isEnabled
    }

    // MARK: - Body

    public func makeBody(configuration: Self.Configuration) -> AnyView {
        let content = ToolBarItemContent(
            configuration: configuration,
            scheme: scheme,
            image: image,
            title: title,
            badgeStyle: badgeStyle,
            type: type,
            itemType: itemType,
            isSelected: isSelected
        )
        if type == .horizontal {
            return ToolBarItemHorizontal(
                content: { content })
            .disabled(!isEnabled)
            .eraseToAnyView()
        } else {
            return ToolBarItemVertical(
                content: { content }
            )
            .disabled(!isEnabled)
            .eraseToAnyView()
        }
    }

}

@available(iOS 14.0.0, *)
private extension ToolBarItemStyle {

    struct ToolBarItemContent: View {

        // MARK: - Contants

        private enum Constants {
            static let imageSize: CGFloat = LayoutGrid.module * 4
        }

        @Environment(\.isEnabled) private var isEnabled

        let configuration: Configuration
        let scheme: ToolBarItemScheme
        let image: Image
        let title: String
        let badgeStyle: ToolBarBadgeStyle?
        let type: ToolBarType
        let itemType: ToolbarItemType
        let isSelected: Bool

        // MARK: - Computed Properties

        private var imageColor: Color? {
            var imageColor = isSelected
            ? scheme.imageColor.parameter(for: .highlighted, type: itemType)?.swiftUIColor
            : scheme.imageColor.parameter(for: .normal, type: itemType)?.swiftUIColor
            if !isEnabled {
                imageColor = scheme.imageColor.parameter(for: .disabled, type: itemType)?.swiftUIColor
            }
            return imageColor
        }

        private var titleColor: Color? {
            var titleColor = isSelected
            ? scheme.titleColor.parameter(for: .highlighted, type: itemType)?.swiftUIColor
            : scheme.titleColor.parameter(for: .normal, type: itemType)?.swiftUIColor
            if !isEnabled {
                titleColor = scheme.titleColor.parameter(for: .disabled, type: itemType)?.swiftUIColor
            }
            return titleColor
        }

        // MARK: - Body

        var body: some View {
            if let badgeStyle = badgeStyle {
                switch badgeStyle {
                case .empty:
                    BadgeView(
                        badgeStyle: .error,
                        value: nil,
                        borderColor: scheme.borderColor.swiftUIColor
                    ) {
                        imageView
                    }
                case .value(let value):
                    BadgeView(
                        badgeStyle: .error,
                        value: value,
                        borderColor: scheme.borderColor.swiftUIColor
                    ) {
                        imageView
                    }
                }
            } else {
                imageView
            }
            Text(title)
                .font(type == .vertical ? scheme.titleLabelVerticalFont.swiftUIFont : scheme.titleLabelHorizontalFont.swiftUIFont)
                .foregroundColor(titleColor)
        }

        // MARK: - Layouts

        private var imageView: some View {
            image
                .renderingMode(.template)
                .foregroundColor(imageColor)
                .frame(width: Constants.imageSize, height: Constants.imageSize)
        }

    }

    private struct ToolBarItemVertical<Content>: View where Content: View {

        // MARK: - Private Properties

        @Environment(\.isEnabled) private var isEnabled

        private let content: Content

        // MARK: - Initializer

        init(@ViewBuilder content: () -> Content) {
            self.content = content()
        }

        // MARK: - Body

        var body: some View {
            Spacer()
            VStack {
                content
            }
            Spacer()
        }
    }

    private struct ToolBarItemHorizontal<Content>: View where Content: View {

        // MARK: - Private Properties

        @Environment(\.isEnabled) private var isEnabled

        private let content: Content

        // MARK: - Initializer

        init(@ViewBuilder content: () -> Content) {
            self.content = content()
        }

        // MARK: - Body

        var body: some View {
            Spacer()
            HStack(spacing: LayoutGrid.halfModule * 3) {
                content
            }
            Spacer()
        }
    }
}
