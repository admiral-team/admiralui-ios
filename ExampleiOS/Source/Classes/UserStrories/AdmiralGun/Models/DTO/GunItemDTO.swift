//
//  ItemDTO.swift
//  ExampleiOS
//
//  Created by on 05.03.2022.
//

import Foundation

struct GunItemDTO: Decodable {
    let description: String
    let id: String
    let parameters: GunParametersDTO
}

extension GunItemDTO {

    func convertToPlain() -> GunItem {
        GunItem(
            description: description,
            id: .init(rawValue: id) ?? .unknown,
            parameters: parameters.convertToPlain()
        )
    }

}
