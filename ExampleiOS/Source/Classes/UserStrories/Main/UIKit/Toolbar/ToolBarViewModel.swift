//
//  ToolBarViewModel.swift
//  ExampleiOS
//
//  Created on 07.05.2022.
//

import AdmiralUIKit
import AdmiralTheme
import AdmiralUIResources
import Foundation

final class ToolBarViewModel {

    // MARK: - Internal Properties

    var sliceItemArray = [
        ToolbarItem(title: "Оплатить", image: Asset.Toolbar.card.image),
        ToolbarItem(title: "Пополнить", image: Asset.Toolbar.getCash.image),
        ToolbarItem(title: "Подробнее", image: Asset.Toolbar.info.image),
        ToolbarItem(title: "Настройки", image: Asset.Toolbar.settings.image)
    ]

}
