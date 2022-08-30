//
//  File.swift
//  AdmiralSwiftUI
//
//  Created by Борисов Кирилл Анатольевич on 22.08.2022.
//
import SwiftUI

@available(iOS 14.0.0, *)
public struct ToolBarItemSelectable: View {

    // MARK: - Internal Properties

    @StateObject var viewRouter: ToolBarViewRouter
    let scheme: ToolBarItemScheme
    let assignedPage: Int
    let image: Image
    let title: String
    let badgeStyle: ToolBarBadgeStyle?
    let itemType: ToolbarItemType
    let onTap: (Int) -> ()
    let isEnabled: Bool

    // MARK: - Computed Properties

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

    // MARK: - Body

    public var body: some View {
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
