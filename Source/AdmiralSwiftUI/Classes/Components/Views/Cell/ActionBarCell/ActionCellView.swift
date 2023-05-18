//
//  ActionCellView.swift
//  AdmiralSwiftUI
//
//  Created on 23.06.2021.
//

import SwiftUI
import AdmiralUIResources
import AdmiralTheme

/// The style of ActionCellView.
public enum ActionBarViewStyle {
    /// The default style of ActionBarViewStyle.
    case `default`
    /// The two style of ActionBarViewStyle.
    case secondary
}

/**
 ActionCellView - A view object for present action bar.
 
 You can create a ActionCellView with the zero frame rectangle by specifying the following parameters in init:

 - cellView: T - Cell view with protocol ListViewCell
 - actions: [ActionItemBarAction] - array of ActionItemBarAction

 ## Example to create ActionCellView
 # Code
 ```
 ActionCellView(cellView: ListCell(centerView: {
     TitleMoreDetailTextMessageListView(
         title: "Title",
         more: "More",
         detaile: "Summ",
         detaileMore: "More",
         subtitle: "Subtitle",
         tagText: "Percent",
         messageText: "Text message")
 }, trailingView: {
     ArrowListView()
 }), actions: [
     ActionItemBarAction(
         image: Image("Your image"),
         handler: {}),
     ActionItemBarAction(
         image: Image("Your image"),
         handler: {}),
     ActionItemBarAction(
         image: Image("Your image"),
         handler: {})])
```
 */
/// A view object for present action bar.
@available(iOS 14.0.0, *)
public struct ActionCellView<T>: View where T: ListViewCell {

    // MARK: - Constants

    private let secondaryOffset: CGFloat = 90

    // MARK: - Public Properties
    
    /// Cell view.
    public let cellView: T
    public var actions: [ActionItemBarAction] = []
    
    // MARK: Internal Properties
    
    @Environment(\.isEnabled) var isEnabled

    // MARK: - Private Properties

    private var style: ActionBarViewStyle
    @State private var cellViewOffset: CGFloat = 0.0
    @ObservedObject private var schemeProvider: SchemeProvider<ActionCellViewScheme>

    private var isOpen: Bool = false
    
    // MARK: - Initializer
    
    public init(
        cellView: T,
        actions: [ActionItemBarAction],
        style: ActionBarViewStyle = .default,
        schemeProvider: SchemeProvider<ActionCellViewScheme> = AppThemeSchemeProvider<ActionCellViewScheme>()
    ) {
        self.cellView = cellView
        self.style = style
        self.actions = actions
        self.schemeProvider = schemeProvider
    }

    public init(
        cellView: T,
        style: ActionBarViewStyle = .default,
        schemeProvider: SchemeProvider<ActionCellViewScheme> = AppThemeSchemeProvider<ActionCellViewScheme>()
    ) {
        self.cellView = cellView
        self.style = style
        self.schemeProvider = schemeProvider
    }

    // MARK: - Layout

    public var body: some View {
        let scheme = schemeProvider.scheme
        ZStack {
            scheme.actionBarBackgroundColor.parameter(for: .normal)?.swiftUIColor
                .frame(height: LayoutGrid.halfModule * 17)
            HStack {
                Spacer()
                ActionBarView(actions: actions, style: style)
            }
            .frame(height: LayoutGrid.halfModule * 17)
            cellView
                .offset(x: cellViewOffset)
                .animation(.easeInOut)
                .gesture(
                    DragGesture(minimumDistance: 0, coordinateSpace: .local)
                        .onChanged({ value in
                            if value.translation.width < 0 {
                                cellViewOffset = max(-maxOffset(), value.translation.width)
                            }
                        }
                                  )
                        .onEnded({ value in
                            if value.translation.width < -LayoutGrid.quadrupleModule {
                                cellViewOffset = -maxOffset()
                            } else {
                                cellViewOffset = 0
                            }
                        }
                    )
                )
        }
    }

    // MARK: - Private methods

    private func maxOffset() -> CGFloat {
        switch style {
        case .default:
            return LayoutGrid.quadrupleModule * CGFloat(actions.count) +
            LayoutGrid.halfModule * 3 * CGFloat(actions.count) +
            LayoutGrid.doubleModule
        case .secondary:
            return secondaryOffset * CGFloat(actions.count)
        }
    }

}

@available(iOS 14.0, *)
struct ActionCellView_Previews: PreviewProvider {
    
    static var previews: some View {
        ActionCellView(cellView: ListCell(centerView: {
            TitleMoreDetailTextMessageListView(
                title: "Title",
                more: "More",
                detaile: "Summ",
                detaileMore: "More",
                subtitle: "Subtitle",
                tagText: "Percent",
                messageText: "Text message")
        }, trailingView: {
            ArrowListView()
        }), actions: [
            ActionItemBarAction(
                image: Image(uiImage: ImagesNew.Category.Outline.acceptOutline.image),
                imageStyle: .accent,
                handler: {}),
            ActionItemBarAction(
                image: Image(uiImage: ImagesNew.Category.Outline.acceptOutline.image),
                imageStyle: .accent,
                handler: {}
            ),
            ActionItemBarAction(
                image: Image(uiImage: ImagesNew.Category.Outline.acceptOutline.image),
                imageStyle: .accent,
                handler: {}
            )
        ], style: .default
        )
        .frame(height: 150.0)
    }
}
