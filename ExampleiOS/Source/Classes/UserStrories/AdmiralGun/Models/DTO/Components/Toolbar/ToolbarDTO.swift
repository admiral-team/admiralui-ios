//
//  ToolbarPlainDTO.swift
//  ExampleiOS
//
//  Created by on 06.03.2022.
//

import Foundation

struct ToolbarDTO: Decodable {
    let elements: [ToolBarElementDTO]?
}

extension ToolbarDTO {

    func convertToPlain() -> ToolBarPlain {
        var elementsPlain: [ToolBarElement]?

        if let elements = elements {
            elementsPlain = elements.map { $0.convertToPlain() }
        }

        return ToolBarPlain(elements: elementsPlain)
    }

}
