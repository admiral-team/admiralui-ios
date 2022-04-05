//
//  SmallBadgesView.swift
//  ExampleiOS
//
//  Created on 04.04.2022.
//

import SwiftUI
import AdmiralTheme
import AdmiralSwiftUI
import AdmiralUIResources

@available(iOS 14.0.0, *)
struct SmallBadgesSwiftUIView: View {

    @State private var scheme: BadgesSwiftUIViewScheme?
    @StateObject private var viewModel = SmallBadgesViewModel()
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<BadgesSwiftUIViewScheme>()

    var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(navigationTitle: "Small") {
            scheme.backgroundColor.swiftUIColor
            ScrollView(.vertical, showsIndicators: false) {
                StandardTab(items: viewModel.tabsItems, selection: $viewModel.isEnabledControlsState)
                VStack(
                    alignment: .center,
                    spacing: LayoutGrid.doubleModule
                ) {
                    ForEach(0..<viewModel.items.count, id: \.self) { index in
                        badgeView(index: index)
                    }
                    Spacer()
                }
                .disabled(viewModel.isEnabledControlsState != 0)
            }
            .padding(LayoutGrid.doubleModule)
        }

    }

    private func badgeView(index: Int) -> some View {
        let scheme = self.scheme ?? schemeProvider.scheme
        return HStack(spacing: .zero, content: {
            BadgeView(
                badgeStyle: viewModel.items[index].badgeStyle,
                value: viewModel.items[index].rawValue,
                offset: CGPoint(x: -LayoutGrid.halfModule, y: .zero)
            ) {
                AssetSymbol.Category.Solid.bonus.image
                    .foregroundColor(scheme.imageTintColor.swiftUIColor)
                    .frame(width: LayoutGrid.halfModule * 11, height: LayoutGrid.halfModule * 11)
                    .background(
                        RoundedRectangle(cornerRadius: LayoutGrid.halfModule * 11 / 2)
                            .foregroundColor(scheme.backgroundImageColor.swiftUIColor)
                    )
            }
            Spacer()
                .frame(width: LayoutGrid.doubleModule)
            Text(viewModel.items[index].title)
                .font(scheme.textFont.swiftUIFont)
                .foregroundColor(scheme.textColor.swiftUIColor)
            Spacer()
            ArrowListView()
            Spacer()
                .frame(width: LayoutGrid.halfModule / 2)
        })
        .frame(height: LayoutGrid.doubleModule * 4)
    }


}
