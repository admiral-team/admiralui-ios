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
    
    @StateObject var viewModel = AdmiralGunViewModel(provider: AdmiralGunProvider())
    @ObservedObject private var schemeProvider = SwiftUISchemeProvider<SwiftUIContentViewScheme>()
    
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
                    LazyVStack(alignment: .leading, spacing: LayoutGrid.doubleModule) {
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
        switch item.parameters {
        case .switcher(var switcherModel):
            return CustomSwitch(isOn:
                Binding<Bool>(
                    get: { !switcherModel.enabled },
                    set: { switcherModel.enabled = !$0 }
                )
            )
            .eraseToAnyView()
        case .primaryButtton(var button):
            return SwiftUI.Button(button.text ?? "", action: { button.isLoading.toggle() })
                .buttonStyle(PrimaryButtonStyle(
                    isLoading: Binding<Bool>(
                        get: { !button.isLoading },
                        set: { button.isLoading = !$0 }
                    ),
                    sizeType: .small
                )
            )
            .eraseToAnyView()
        case .tab(var tabModel):
            return StandardTab(
                items: tabModel.titles ?? [],
                selection: Binding<Int>(
                    get: { 0 },
                    set: { tabModel.selectedIndex = $0 }
                )
            )
            .eraseToAnyView()
        case .toolBar(let toolBarModel):
            let elements = toolBarModel.elements ?? []
            return ToolBar(
                items: .constant(elements.map {
                    ToolBarItem(title: $0.title, image: Image(uiImage: Asset.Toolbar.settings.image))
                }),
                type: .constant(.horizontal),
                selectedIndex: .constant(0),
                onTap: { _ in }
            )
            .eraseToAnyView()
        case .standartTextField(let textFieldModel):
            return StandardTextField(
                value: .constant(textFieldModel.text),
                accessibilityIdentifier: "testTextField",
                formatter: BlocFormatter(format: { text in
                    text?.replacingOccurrences(of: "=)", with: "🙂")
                }),
                contentType: .default,
                placeholder: textFieldModel.additionalText ?? "",
                name: "Optional label",
                state: .constant(.normal),
                info: .constant(textFieldModel.additionalText ?? ""),
                infoNumberOfLines: nil,
                isResponder: .constant(false),
                onSubmit: {}
            )
            .eraseToAnyView()
        default:
            return EmptyView()
                 .eraseToAnyView()
        }
    }

}
