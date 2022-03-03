//
//  LinksSwiftUIView.swift
//  ExampleiOS
//
//  Created on 11.11.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralSwiftUI
import AdmiralUIResources

@available(iOS 14.0.0, *)
struct LinksSwiftUIView: View {

    // MARK: - Private properties

    @State private var isEnabledControlsState: Int = 0
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<SwiftUIContentViewScheme>()
    
    public var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(navigationTitle: "Links") {
            scheme.backgroundColor.swiftUIColor
            VStack(alignment: .leading, spacing: LayoutGrid.tripleModule) {
                StandardTab(items: ["Default", "Disabled"], selection: $isEnabledControlsState)
                Spacer()
                    .frame(height: LayoutGrid.halfModule)
                VStack(alignment: .leading, spacing: LayoutGrid.tripleModule) {
                    Text("24 Link")
                        .font(scheme.textFont.swiftUIFont)
                        .foregroundColor(scheme.textColor.swiftUIColor)
                    HStack(spacing: LayoutGrid.tripleModule) {
                        SwiftUI.Button("Small Button", action: {})
                            .buttonStyle(PrimaryLinkControlStyle(
                                image: Image(uiImage: Asset.Links.arrowLeftBig.image),
                                text: "Link",
                                direction: .left,
                                style: .default
                            ))
                            .disabled(isEnabledControlsState != 0)
                        SwiftUI.Button("Small Button", action: {})
                            .buttonStyle(PrimaryLinkControlStyle(
                                image: Image(uiImage: Asset.Links.arrowRightBig.image),
                                text: "Link",
                                direction: .right,
                                style: .default
                            ))
                            .disabled(isEnabledControlsState != 0)
                        SwiftUI.Button("Small Button", action: {})
                            .buttonStyle(PrimaryLinkControlStyle(
                                image: nil,
                                text: "Link",
                                direction: .left,
                                style: .default
                            ))
                            .disabled(isEnabledControlsState != 0)
                    }
                }
                VStack(alignment: .leading, spacing: LayoutGrid.tripleModule) {
                    Spacer()
                        .frame(height: LayoutGrid.module)
                    Text("18 Link")
                        .font(scheme.textFont.swiftUIFont)
                        .foregroundColor(scheme.textColor.swiftUIColor)
                    HStack(spacing: LayoutGrid.tripleModule) {
                        SwiftUI.Button("Small Button", action: {})
                            .buttonStyle(PrimaryLinkControlStyle(
                                image: Image(uiImage: Asset.Links.arrowLeftSmall.image),
                                text: "Link",
                                direction: .left,
                                style: .medium
                            ))
                            .disabled(isEnabledControlsState != 0)
                        SwiftUI.Button("Small Button", action: {})
                            .buttonStyle(PrimaryLinkControlStyle(
                                image: Image(uiImage: Asset.Links.arrowRightSmall.image),
                                text: "Link",
                                direction: .right,
                                style: .medium
                            ))
                            .disabled(isEnabledControlsState != 0)
                        SwiftUI.Button("Small Button", action: {})
                            .buttonStyle(PrimaryLinkControlStyle(
                                image: nil,
                                text: "Link",
                                direction: .left,
                                style: .medium
                            ))
                            .disabled(isEnabledControlsState != 0)
                    }

                }
                Spacer()
            }
            .padding()
        }
    }

}
