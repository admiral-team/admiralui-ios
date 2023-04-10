//
//  ToolBar.swift
//  AdmiralUIResources
//
//  Created on 31.05.2021.
//
import AdmiralCore
import AdmiralTheme
import AdmiralUIResources
import SwiftUI
/// The style of ToolBar items.
public enum ToolBarType {
    /// The value that sets potion of the text at the right edge
    case horizontal
    /// The value that sets postion of text under the image
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
        static let height: CGFloat = LayoutGrid.doubleModule * 3
        static let cornerRadius: CGFloat = LayoutGrid.doubleModule
        static let edgeInsets: EdgeInsets = EdgeInsets(
            top: LayoutGrid.doubleModule,
            leading: LayoutGrid.halfModule * 5,
            bottom: LayoutGrid.doubleModule,
            trailing: LayoutGrid.halfModule * 5
        )
        static let width: CGFloat = UIScreen.main.bounds.width - (LayoutGrid.module * 9)
        static let oneItemWidth: CGFloat = LayoutGrid.halfModule * 35
        static let overlayRadius: CGFloat = LayoutGrid.doubleModule - 2
    }
    
    // MARK: - Internal Properties
    
    @Environment(\.isEnabled) var isEnabled
    
    // MARK: - Private Properties

    @Binding  private var items: [ToolBarItem]
    @Binding private var type: ToolBarType
    @Binding private var selectedIndex: Int

    @ObservedObject private var schemeProvider: SchemeProvider<ToolBarScheme> = AppThemeSchemeProvider<ToolBarScheme>()

    private let isSelectable: Bool
    private let onTap: (Int) -> ()

    // MARK: - Internal Properties

    @State var currentPage = 0

    // MARK: - Initializer

    /// Initializes and returns a newly allocated ToolBar object.
    /// - Parameters:
    ///   - items: Items of ToolBar
    ///   - type: Type of ToolBar items horizontal or vertical, vertical by default
    ///   - onTap: The callback action by tapping the button
    ///   - isSelectable: Defines ToolBar item behavior on tap: highllight or select
    ///   - schemeProvider: Sheme provider serves for change theme.
    public init(
        items: Binding<[ToolBarItem]>,
        type: Binding<ToolBarType>,
        selectedIndex: Binding<Int>,
        onTap: @escaping (Int) ->(),
        isSelectable: Bool = true,
        schemeProvider: SchemeProvider<ToolBarScheme> = AppThemeSchemeProvider<ToolBarScheme>()
    ) {
        self._items = items
        self._type = type
        self._selectedIndex = selectedIndex
        self.onTap = onTap
        self.isSelectable = isSelectable
        self.schemeProvider = schemeProvider
    }

    // MARK: - Body

    public var body: some View {
        let scheme = schemeProvider.scheme
        HStack {
            ForEach(0...items.count - 1, id: \.self) { i in
                let item = items[i]
                if items.count > 1 && isSelectable {
                    ToolBarItemSelectable(
                        currentPage: $currentPage,
                        scheme: scheme.itemScheme,
                        assignedPage: i,
                        image: item.image,
                        title: item.title,
                        badgeStyle: item.badgeStyle,
                        itemType: item.type,
                        onTap: onTap,
                        isEnabled: item.isEnabled,
                        accessibityId: item.accessibilityId
                    )
                } else {
                    Button(action: {
                        guard item.isEnabled else { return }
                        tapItem(id: i)
                    }, label: {})
                    .buttonStyle(
                        ToolBarItemStyle(
                            scheme: scheme.itemScheme,
                            image: item.image,
                            title: item.title,
                            badgeStyle: item.badgeStyle,
                            type: type,
                            itemType: item.type,
                            isSelected: currentPage == i,
                            isEnabled: item.isEnabled
                        )
                    )
                    .accessibility(identifier: item.accessibilityId)
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
                    radius: Constants.overlayRadius,
                    x: 0,
                    y: LayoutGrid.halfModule
                )
                .foregroundColor(scheme.backgroundColor.swiftUIColor)
        )
    }

    // MARK: - Private Methods

    private func tapItem(id: Int) {
        currentPage = id
        onTap(id)
    }

}
