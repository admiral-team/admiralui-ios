//
//  ActionBarView.swift
//  AdmiralSwiftUI
//
//  Created on 23.06.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralUIResources
/**
 ActionBarView - A view for ActionCellView with array of ActionItemBarAction

 You can create a ActionBarView with the zero frame rectangle by specifying the following parameters in init:

 - actions: [ActionItemBarAction] - array of ActionItemBarAction.
 - style: ActionBarViewStyle - the style of ActionBarView.

 ## Example to create ActionBarView
 # Code
 ```
 ActionBarView(
     actions: [ActionItemBarAction(
                 image: "Your image1",
                 handler: {}),
               ActionItemBarAction(
                 image: "Your image2",
                           handler: {}),
               ActionItemBarAction(
                 image: Image("Your image3"),
                           handler: {})])
```
 */
@available(iOS 14.0.0, *)
struct ActionBarView: View {

    // MARK: Internal Properties

    @Environment(\.isEnabled) var isEnabled
    private var actions: [ActionItemBarAction]
    private var style: ActionBarViewStyle

    // MARK: - Private Properties

    @State private var scheme: ActionBarViewScheme? = nil
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<ActionBarViewScheme>()

    // MARK: - Initializer

    /// Initializes and returns a newly allocated view object with the zero frame rectangle.
    init(actions: [ActionItemBarAction], style: ActionBarViewStyle = .default) {
        self.actions = actions
        self.style = style
    }

    // MARK: - Layout

    public var body: some View {
        let scheme = self.scheme ?? schemeProvider.scheme
        contentView(scheme: scheme)
            .background(scheme.backgroundColor.parameter(for: .normal)?.swiftUIColor)
    }

    // MARK: - Private methods

    @ViewBuilder
    private func contentView(scheme:  ActionBarViewScheme) -> some View {
        switch style {
        case .default:
            VStack {
                Spacer()
                HStack(spacing: LayoutGrid.halfModule * 3) {
                    Spacer()
                    Spacer()
                        .frame(width: LayoutGrid.doubleModule)
                    ForEach(actions, id: \.self) { action in
                        controlView(action: action, scheme: scheme)
                    }
                    Spacer()
                        .frame(width: LayoutGrid.halfModule)
                }
                Spacer()
            }
        case .secondary:
            HStack(spacing: .zero) {
                ForEach(actions, id: \.id) { action in
                    controlView(action: action, scheme: scheme)
                }
            }
        }
    }

    @ViewBuilder
    private func controlView(action: ActionItemBarAction, scheme:  ActionBarViewScheme) -> some View {
        switch action.style {
        case .default:
            ActionBarControlView(
                image: action.image,
                imageStyle: action.imageStyle ?? .accent,
                tapActionBar: action.handler
            )
            .scheme(scheme.actionBarConrolScheme)
        case .secondary:
            ActionBarControlViewSecondary(
                image: action.image,
                imageStyle: action.imageStyle,
                backgroundColor: action.backgroundColor,
                imageTintColor: action.imageTintColor,
                style: action.style,
                text: action.text,
                tapActionBar: action.handler
            )
            .scheme(scheme.actionBarConrolSchemeTwo)
        }
    }

}


@available(iOS 14.0, *)
struct ActionBarView_Previews: PreviewProvider {

    static var previews: some View {
        ActionBarView(
            actions: [
                ActionItemBarAction(
                    image: Image(uiImage: Asset.Category.Outline.acceptOutline.image),
                    imageStyle: .accent,
                    handler: {}
                ),
                ActionItemBarAction(
                    image: Image(uiImage: Asset.Category.Outline.acceptOutline.image),
                    imageStyle: .accent,
                    handler: {}
                ),
                ActionItemBarAction(
                    image: Image(uiImage: Asset.Category.Outline.acceptOutline.image),
                    imageStyle: .accent,
                    handler: {}
                )
            ]
        )
    }

}
