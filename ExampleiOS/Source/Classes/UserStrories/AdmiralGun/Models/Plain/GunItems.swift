//
//  GunItems.swift
//  ExampleiOS
//
//  Created by on 05.03.2022.
//

import Foundation

struct GunItems: Hashable {

    let id = UUID().uuidString
    let error: String?
    let items: [GunItem]

    static func == (lhs: GunItems, rhs: GunItems) -> Bool {
        lhs.id == rhs.id
    }

}
