//
//  ToolBarItemStyle.swift
//  AdmiralSwiftUI
//
//  Created on 31.05.2021.
//

import SwiftUI

import AdmiralTheme
import AdmiralUIResources

@available(iOS 14.0.0, *)
struct ToolBarItemStyle: ButtonStyle {

    var image: Image
    var title: String
    var badgeStyle: ToolBarBadgeStyle?
    var type: ToolBarType
    var scheme: ToolBarScheme.ItemScheme
    var isSelected: Bool
    var itemType: ToolbarItemType
    var isEnabled: Bool
    
    init(
        scheme: ToolBarScheme.ItemScheme,
        image: Image,
        title: String,
        badgeStyle: ToolBarBadgeStyle?,
        type: ToolBarType,
        itemType: ToolbarItemType,
        isSelected: Bool,
        isEnabled: Bool) {
        self.scheme = scheme
        self.image = image
        self.title = title
        self.badgeStyle = badgeStyle
        self.type = type
        self.itemType = itemType
        self.isSelected = isSelected
        self.isEnabled = isEnabled
    }
    
    public func makeBody(configuration: Self.Configuration) -> AnyView {
        let content = ToolBarItemContent(
            configuration: configuration,
            scheme: scheme,
            image: image,
            title: title,
            badgeStyle: badgeStyle,
            type: type,
            itemType: itemType,
            isSelected: isSelected)
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
extension ToolBarItemStyle {
    
    struct ToolBarItemContent: View {
        @Environment(\.isEnabled) private var isEnabled
        
        let configuration: Configuration
        let scheme: ToolBarScheme.ItemScheme
        let image: Image
        let title: String
        let badgeStyle: ToolBarBadgeStyle?
        let type: ToolBarType
        let itemType: ToolbarItemType
        let isSelected: Bool
        
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
        
        var body: some View {
            if let badgeStyle = badgeStyle {
                switch badgeStyle {
                case .empty:
                    BadgeView(badgeStyle: .error,
                              value: nil,
                              borderColor: scheme.borderColor.swiftUIColor) {
                        image
                            .renderingMode(.template)
                            .foregroundColor(imageColor)
                            .frame(width: 32.0, height: 32.0)
                    }
                case .value(let value):
                    BadgeView(badgeStyle: .error,
                              value: value,
                              borderColor: scheme.borderColor.swiftUIColor) {
                        image
                            .renderingMode(.template)
                            .foregroundColor(imageColor)
                            .frame(width: 32.0, height: 32.0)
                    }
                }
            } else {
                image
                    .renderingMode(.template)
                    .foregroundColor(imageColor)
                    .frame(width: 32.0, height: 32.0)
            }
            Text(title)
                .font(type == .vertical ? scheme.titleLabelVerticalFont.swiftUIFont : scheme.titleLabelHorizontalFont.swiftUIFont)
                .foregroundColor(titleColor)
        }
    }
    
    struct ToolBarItemVertical<Content>: View where Content: View {
        
        @Environment(\.isEnabled) private var isEnabled
        
        let content: Content
        
        init(@ViewBuilder content: () -> Content) {
            self.content = content()
        }
        
        var body: some View {
            Spacer()
            VStack {
                content
            }
            Spacer()
        }
    }
    
    struct ToolBarItemHorizontal<Content>: View where Content: View {
        
        @Environment(\.isEnabled) private var isEnabled
        
        let content: Content
        
        init(@ViewBuilder content: () -> Content) {
            self.content = content()
        }
        
        var body: some View {
            Spacer()
            HStack(spacing: 12.0) {
                content
            }
            Spacer()
        }
    }
}

@available(iOS 14.0.0, *)
class ViewRouter: ObservableObject {
    
    @Published var currentPage: Int = 0
    
}

@available(iOS 14.0.0, *)
struct ToolBarItemSelectable: View {
    
    @StateObject var viewRouter: ViewRouter
    let scheme: ToolBarScheme.ItemScheme
    let assignedPage: Int
    let image: Image
    let title: String
    let badgeStyle: ToolBarBadgeStyle?
    let itemType: ToolbarItemType
    let onTap: (Int) -> ()
    let isEnabled: Bool
    
    private var imageColor: Color? {
        var imageColor = viewRouter.currentPage == assignedPage
            ? scheme.imageColor.parameter(for: .highlighted, type: itemType)?.swiftUIColor
            : scheme.imageColor.parameter(for: .normal, type: itemType)?.swiftUIColor
        if !isEnabled {
            imageColor = scheme.imageColor.parameter(for: .disabled, type: itemType)?.swiftUIColor
        }
        return imageColor
    }
    
    private var titleColor: Color? {
        var titleColor = viewRouter.currentPage == assignedPage
            ? scheme.titleColor.parameter(for: .highlighted, type: itemType)?.swiftUIColor
            : scheme.titleColor.parameter(for: .normal, type: itemType)?.swiftUIColor
        if !isEnabled {
            titleColor = scheme.titleColor.parameter(for: .disabled, type: itemType)?.swiftUIColor
        }
        return titleColor
    }
    
    var body: some View {
        Spacer()
        VStack {
            if let badgeStyle = badgeStyle {
                switch badgeStyle {
                case .empty:
                    BadgeView(badgeStyle: .error,
                              value: nil,
                              borderColor: scheme.borderColor.swiftUIColor) {
                        image
                            .renderingMode(.template)
                            .foregroundColor(imageColor)
                            .frame(width: 32.0, height: 32.0)
                    }
                    .disabled(!isEnabled)
                case .value(let value):
                    BadgeView(badgeStyle: .error,
                              value: value,
                              borderColor: scheme.borderColor.swiftUIColor) {
                        image
                            .renderingMode(.template)
                            .foregroundColor(titleColor)
                            .frame(width: 32.0, height: 32.0)
                    }
                    .disabled(!isEnabled)
                }
            } else {
                image
                    .renderingMode(.template)
                    .foregroundColor(imageColor)
                    .frame(width: 32.0, height: 32.0)
            }
            Text(title)
                .font(scheme.titleLabelVerticalFont.swiftUIFont)
                .foregroundColor(titleColor)
        }
        .onTapGesture {
            guard isEnabled else { return }
            
            onTap(assignedPage)
            viewRouter.currentPage = assignedPage
        }
        Spacer()
    }
    
}
