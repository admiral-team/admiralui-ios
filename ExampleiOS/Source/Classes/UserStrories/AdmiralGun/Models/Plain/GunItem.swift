//
//  GunItem.swift
//  ExampleiOS
//
//  Created by on 05.03.2022.
//

import Foundation

struct GunItem: Hashable {

    var uid = UUID().uuidString

    let description: String
    let id: GunItemId
    let parameters: GunType

    static func == (lhs: GunItem, rhs: GunItem) -> Bool {
        lhs.uid == rhs.uid
    }

}
