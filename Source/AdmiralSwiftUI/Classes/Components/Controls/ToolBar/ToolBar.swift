//
//  ToolBar.swift
//  AdmiralUIResources
//
//  Created on 31.05.2021.
//

import AdmiralTheme
import AdmiralUIResources
import SwiftUI

/// The style of ToolBar items.
public enum ToolBarType {
    case horizontal
    case vertical
}

/**
 ToolBar - A control that displays one or more buttons vertically or horizontally.

 ToolBar can be vertical or horizontal. To create a horizontal or vertical ToolBar, you must specify type in the initializer.
 ## Initializer parameters:
 - items - array Items of ToolBar (ToolBarItem)
 - type - type of ToolBar items horizontal or vertical, vertical by default
 - onTap - the callback action by tapping the button
 - isSelectable - defines ToolBar item behavior on tap: highllight or select
 ## Example to create vertical ToolBar:
 # Code
 ```
 @State private var toolbarType: ToolBarType = .vertical
 @State private var selectedIndex: Int
 private var items = [ToolBarItem]()
 ToolBar(
 items: $sliceItemArray,
 type: $toolbarType,
 selectedIndex: $selectedIndex,
 onTap: { index in
 print(index)
 })
 ```
 */
@available(iOS 14.0.0, *)
/// An object that displays a ToolBar .
public struct ToolBar: View {

    // MARK: - Constants

    private enum Constants {
        static let height: CGFloat = 48.0
        static let cornerRadius: CGFloat = 16.0
        static let edgeInsets: EdgeInsets = EdgeInsets(
            top: 16.0,
            leading: 20.0,
            bottom: 16.0,
            trailing: 20.0)
        static let width: CGFloat = UIScreen.main.bounds.width - 72.0
        static let oneItemWidth: CGFloat = 140.0
    }

    // MARK: - Internal Properties

    @Environment(\.isEnabled) var isEnabled

    @StateObject var viewRouter = ToolBarViewRouter()

    // MARK: - Private Properties

    @Binding private var items: [ToolBarItem]
    @Binding private var type: ToolBarType
    @Binding private var selectedIndex: Int

    private let isSelectable: Bool
    private let onTap: (Int) -> ()

    @Binding private var scheme: ToolBarScheme?
    private var itemScheme: ToolBarItemScheme?

    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<ToolBarScheme>()
    @ObservedObject private var itemSchemeProvider = AppThemeSchemeProvider<ToolBarItemScheme>()

    // MARK: - Initializer

    /// Initializes and returns a newly allocated ToolBar object.
    /// - Parameters:
    ///   - items: Items of ToolBar
    ///   - type: Type of ToolBar items horizontal or vertical, vertical by default
    ///   - onTap: The callback action by tapping the button
    ///   - isSelectable: Defines ToolBar item behavior on tap: highllight or select
    public init(
        items: Binding<[ToolBarItem]>,
        type: Binding<ToolBarType>,
        selectedIndex: Binding<Int>,
        onTap: @escaping (Int) ->(),
        isSelectable: Bool = true,
        scheme: Binding<ToolBarScheme?> = .constant(nil),
        itemScheme: ToolBarItemScheme? = nil
    ) {
        self._items = items
        self._type = type
        self._selectedIndex = selectedIndex
        self._scheme = scheme
        self.itemScheme = itemScheme
        self.onTap = onTap
        self.isSelectable = isSelectable
    }

    // MARK: - Body

    public var body: some View {
        let scheme = self.scheme ?? schemeProvider.scheme
        let itemScheme = self.itemScheme ?? itemSchemeProvider.scheme
        HStack {
            ForEach(0...items.count - 1, id: \.self) { i in
                let item = items[i]
                if items.count > 1 && isSelectable {
                    ToolBarItemSelectable(
                        viewRouter: viewRouter,
                        scheme: itemScheme,
                        assignedPage: i,
                        image: item.image,
                        title: item.title,
                        badgeStyle: item.badgeStyle,
                        itemType: item.type,
                        onTap: onTap,
                        isEnabled: item.isEnabled
                    )
                } else {
                    Button(action: {
                        guard item.isEnabled else { return }
                        tapItem(id: i)
                    }, label: {})
                    .buttonStyle(
                        ToolBarItemStyle(
                            scheme: itemScheme,
                            image: item.image,
                            title: item.title,
                            badgeStyle: item.badgeStyle,
                            type: type,
                            itemType: item.type,
                            isSelected: viewRouter.currentPage == i,
                            isEnabled: item.isEnabled
                        )
                    )
                }
            }
        }
        .frame(
            width: items.count > 1 ? Constants.width : Constants.oneItemWidth,
            height: Constants.height
        )
        .padding(Constants.edgeInsets)
        .background(
            RoundedRectangle(cornerRadius: Constants.cornerRadius)
                .shadow(
                    color: scheme.shadowColor.swiftUIColor,
                    radius: 14.0,
                    x: 0,
                    y: LayoutGrid.halfModule
                )
                .foregroundColor(scheme.backgroundColor.swiftUIColor)
        )
    }

    // MARK: - Private Methods

    private func tapItem(id: Int) {
        viewRouter.currentPage = id
        onTap(id)
    }

}
