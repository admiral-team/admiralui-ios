//
//  ItemsDTO.swift
//  ExampleiOS
//
//  Created by Borisov Kirill on 05.03.2022.
//

import Foundation

struct GunItemsDTO: Decodable {
    let error: String?
    let items: [GunItemDTO]
}

extension GunItemsDTO {

    func convertToPlain() -> GunItems {
        GunItems(
            error: error,
            items: items.map { $0.convertToPlain() }
        )
    }

}
