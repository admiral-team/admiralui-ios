//
//  NormalBadgesSwiftUIView.swift
//  ExampleiOS
//
//  Created on 04.04.2022.
//

import SwiftUI
import AdmiralTheme
import AdmiralSwiftUI
import AdmiralUIResources

@available(iOS 14.0.0, *)
struct NormalBadgesSwiftUIView: View {

    @State private var scheme: BadgesSwiftUIViewScheme?
    @StateObject private var viewModel = NormalBadgesViewModel()
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<BadgesSwiftUIViewScheme>()

    var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(navigationTitle: "Normal") {
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
        return HStack(alignment: .center, spacing: 0.0, content: {
            BadgeView(
                badgeStyle: viewModel.items[index].badgeStyle,
                value: Int(viewModel.items[index].rawValue),
                offset: CGPoint(x: 6, y: .zero)
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
            InputNumber(
                titleText: .constant(nil),
                value: Binding<Double>(
                    get: { viewModel.items[index].rawValue },
                    set: { viewModel.items[index].rawValue = $0 }
                ),
                minimumValue: .constant(0),
                maximumValue: .constant(1000),
                stepValue: .constant(1.0))
        })
        .frame(height: LayoutGrid.doubleModule * 4)
    }

}
