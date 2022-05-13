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

    @StateObject private var viewModel = LinksSwiftUIViewModel()
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<SwiftUIContentViewScheme>()

    // MARK: - Layout

    public var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(navigationTitle: viewModel.navigationTitle) {
            scheme.backgroundColor.swiftUIColor
            VStack(alignment: .leading, spacing: LayoutGrid.tripleModule) {
                StandardTab(items: viewModel.tabsItems, selection: $viewModel.isEnabledControlsState)
                Spacer()
                    .frame(height: LayoutGrid.halfModule)
                ForEach(0..<viewModel.links.count, id: \.self) { index in
                    linkItem(link: viewModel.links[index], scheme: scheme)
                }
                Spacer()
            }
            .padding()
        }
    }

    // MARK: - Private Methods

    private func linkItem(link: LinksSwiftUIViewModel.LinksSection, scheme: SwiftUIContentViewScheme) -> some View {
        VStack(alignment: .leading, spacing: LayoutGrid.tripleModule) {
            switch link.type {
            case .small(let title):
                Spacer()
                    .frame(height: LayoutGrid.module)
                Text(title)
                    .font(scheme.textFont.swiftUIFont)
                    .foregroundColor(scheme.textColor.swiftUIColor)
            case .medium(let title):
                Text(title)
                    .font(scheme.textFont.swiftUIFont)
                    .foregroundColor(scheme.textColor.swiftUIColor)
            }
            HStack(spacing: LayoutGrid.tripleModule) {
                ForEach(link.links, id: \.id) { item in
                    SwiftUI.Button(item.title, action: {})
                        .buttonStyle(PrimaryLinkControlStyle(
                            image: item.image,
                            text: item.text,
                            direction: item.direction,
                            style: item.style
                        ))
                        .disabled(viewModel.isEnabledControlsState != 0)
                }
            }
        }
    }

}
