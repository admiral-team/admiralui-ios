//
//  ToolBarSwiftUIView.swift
//  ExampleiOS
//
//  Created on 31.05.2021.
//

import SwiftUI
import AdmiralTheme
import AdmiralSwiftUI

@available(iOS 14.0.0, *)
struct ToolBarSwiftUIView: View {
    
    // MARK: - Private Properties
    
    @State private var startValue: Double = 4.0
    @State private var sliceItemArray = [
        ToolBarItem(title: "Оплатить", image: Image(uiImage: Asset.Toolbar.card.image), accessibilityId: "ToolbarPay"),
        ToolBarItem(title: "Пополнить", image: Image(uiImage: Asset.Toolbar.getCash.image), accessibilityId: "ToolbarAdd"),
        ToolBarItem(title: "Подробнее", image: Image(uiImage: Asset.Toolbar.info.image), accessibilityId: "ToolbarDetail"),
        ToolBarItem(title: "Настройки", image: Image(uiImage: Asset.Toolbar.settings.image), accessibilityId: "ToolbarSetting")
    ]
    @State private var toolbarType: ToolBarType = .vertical
    @State private var selectedIndex: Int = 1
    private var items = [ToolBarItem]()
    
    @ObservedObject private var schemeProvider = AppThemeSchemeProvider<SwiftUIContentViewScheme>()
    
    // MARK: - Initielizers
    
    init() {
        items = sliceItemArray
    }
    
    public var body: some View {
        let scheme = schemeProvider.scheme
        NavigationContentView(navigationTitle: "Toolbar") {
            scheme.backgroundColor.swiftUIColor
            VStack {
                InputNumber(
                    titleText: .constant("Количество пунктов"),
                    value: $startValue,
                    minimumValue: .constant(1.0),
                    maximumValue: .constant(4.0),
                    accessibilityIdentifier: "InputNumberToolbar")
                    .onChange(of: startValue, perform: { value in
                        let sliceItems = Array(items[0...(Int(value) - 1)])
                        sliceItemArray = sliceItems
                        toolbarType = sliceItemArray.count > 1 ? .vertical : .horizontal
                    })
                    .padding(LayoutGrid.doubleModule)
                Spacer().frame(height: 16.0)
                ToolBar(
                    items: $sliceItemArray,
                    type: $toolbarType,
                    selectedIndex: $selectedIndex,
                    onTap: { index in
                        print(index)
                    })
                Spacer()
            }
        }
    }
    
}
