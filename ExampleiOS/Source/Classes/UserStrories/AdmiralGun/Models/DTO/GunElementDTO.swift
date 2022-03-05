//
//  ElementDTO.swift
//  ExampleiOS
//
//  Created by Borisov Kirill on 05.03.2022.
//

import Foundation

struct GunElementDTO: Decodable {
    let icon: String
    let title: String
}

extension GunElementDTO {

    func convertToPlain() -> GunElement {
        GunElement(icon: icon, title: title)
    }

}
