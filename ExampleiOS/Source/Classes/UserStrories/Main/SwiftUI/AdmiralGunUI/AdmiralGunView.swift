//
//  AdmiralGunView.swift
//  ExampleiOS
//
//  Created by on 04.03.2022.
//

import SwiftUI
import AdmiralTheme
import AdmiralSwiftUI

@available(iOS 14.0.0, *)
struct AdmiralGunView: View {
    
    @ObservedObject var viewModel = AdmiralGunViewModel(provider: AdmiralGunProvider())
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<SwiftUIContentViewScheme>()
    
    public var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(navigationTitle: "AdmiralGun") {
            scheme.backgroundColor.swiftUIColor
            VStack {
                SearchBar(
                    $viewModel.searchBarText,
                    isResponder: $viewModel.isResponder,
                    placeholder: "Поиск"
                )
                .padding(.leading, LayoutGrid.doubleModule)
                .padding(.trailing, LayoutGrid.doubleModule)
                ScrollView {
                    LazyVStack(alignment: .leading) {
                        ForEach(viewModel.items, id: \.self) { item in
                            buildView(by: item)
                        }
                    }
                    .padding(LayoutGrid.doubleModule)
                    Spacer()
                        .frame(height: LayoutGrid.doubleModule * 4)
                }
            }
        }
    }

    private func buildView(by item: GunItem) -> some View {
        switch item.id {
        case .toolbar:
            let elements = item.parameters.elements ?? []
            return ToolBar(
                items: .constant(elements.map {
                    ToolBarItem(title: $0.title, image: Image(uiImage: Asset.Toolbar.settings.image))
                }),
                type: .constant(.horizontal),
                selectedIndex: .constant(item.parameters.selectedIndex ?? 0),
                onTap: { _ in }
            )
            .eraseToAnyView()
        case .unknown:
            return EmptyView()
                .eraseToAnyView()
        case .tab:
            return StandardTab(items: ["One", "Two"], selection: .constant(0))
                .eraseToAnyView()
        case .switcher:
            return CustomSwitch(isOn: .constant(item.parameters.enabled))
                .eraseToAnyView()
        case .primaryButton:
            return SwiftUI.Button(item.parameters.text ?? "", action: {})
                .buttonStyle(PrimaryButtonStyle(isLoading: .constant(false), sizeType: .small))
                .eraseToAnyView()
        case .standartTextfield:
            return StandardTextField(
                value: .constant(item.parameters.text),
                accessibilityIdentifier: "testTextField",
                formatter: BlocFormatter(format: { text in
                    return text?.replacingOccurrences(of: "=)", with: "🙂")
                }),
                contentType: .default,
                placeholder: item.parameters.additionalText ?? "",
                name: "Optional label",
                state: .constant(.normal),
                info: .constant(item.parameters.additionalText ?? ""),
                infoNumberOfLines: nil,
                isResponder: .constant(false),
                onSubmit: {}
            )
            .eraseToAnyView()
        }

    }


}
