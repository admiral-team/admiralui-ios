//
//  MapButtonsListViewModel.swift
//  ExampleiOS
//
//  Created on 25.02.2022.
//

import AdmiralUIKit
import AdmiralImages
import UIKit

final class MapButtonsListViewModel {

    enum MapButtonItem {
        case map(_ type: MapButtonType)
        case severalPin(_ size: SeveralPinButtonSize, title: String)
        case pin(_ image: UIImage, selection: Bool)
    }

    struct MapButtonModel {
        var title: String
        var buttons: [MapButtonItem]
    }

    // MARK: - Computed Properties

    var segmentContolTitles: [String] {
        ["Default", "Disabled"]
    }

    // MARK: - Properties

    let buttons: [MapButtonModel]

    // MARK: - Inititalizer

    init() {
        buttons = [
            MapButtonModel(title: "Pins", buttons: [
                .pin(AdmiralImages.Asset.Category.Solid.bankSolid.image, selection: false),
                .pin(AdmiralImages.Asset.Finance.Solid.moneySolid.image, selection: false),
                .pin(AdmiralImages.Asset.Finance.Solid.cashSolid.image, selection: false)
            ]),
            MapButtonModel(title: "Several Pins", buttons: [
                .severalPin(.small, title: "2"),
                .severalPin(.medium, title: "22"),
                .severalPin(.large, title: "222")
            ]),
            MapButtonModel(title: "Buttons", buttons: [
                .map(.minus),
                .map(.plus),
                .map(.location)
            ])
        ]
    }

}
