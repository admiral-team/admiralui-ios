//
//  ToolBarSwiftUIViewModel.swift
//  ExampleiOS
//
//  Created on 22.04.2022.
//

import AdmiralSwiftUI
import Combine
import SwiftUI

@available(iOS 14.0.0, *)
final class ToolBarSwiftUIViewModel: ObservableObject {

    // MARK: - Published Properties

    @Published var sliceItemArray = [
        ToolBarItem(title: "Оплатить", image: Image(uiImage: Asset.Toolbar.card.image)),
        ToolBarItem(title: "Пополнить", image: Image(uiImage: Asset.Toolbar.getCash.image)),
        ToolBarItem(title: "Подробнее", image: Image(uiImage: Asset.Toolbar.info.image)),
        ToolBarItem(title: "Настройки", image: Image(uiImage: Asset.Toolbar.settings.image))
    ]
    @Published var startValue: Double = 4.0
    @Published var toolbarType: ToolBarType = .vertical
    @Published var selectedIndex: Int = 1

    // MARK: - Internal Properties

    var navigationTitle: String {
        "Checkbox"
    }
    
    var items = [ToolBarItem]()

}
