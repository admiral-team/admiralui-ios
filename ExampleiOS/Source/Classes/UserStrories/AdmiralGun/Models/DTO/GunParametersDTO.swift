//
//  ParametersDTO.swift
//  ExampleiOS
//
//  Created by on 05.03.2022.
//

import Foundation

struct GunParametersDTO: Decodable {
    let enabled: Bool
    let isIconEnabled: Bool?
    let isLoading: Bool?
    let size: Int?
    let text: String?
    let additionalText: String?
    let optionalLabel: String?
    let state: Int?
    let selectedIndex: Int?
    let titles: [String]?
    let elements: [GunElementDTO]?
    let type: Int?
}

extension GunParametersDTO {

    func convertToPlain() -> GunParameters {
        var elementsPlain: [GunElement]?

        if let elements = elements {
            elementsPlain = elements.map { $0.convertToPlain() }
        }

        return GunParameters(
            enabled: enabled,
            isIconEnabled: isIconEnabled,
            isLoading: isLoading,
            size: size,
            text: text,
            additionalText: additionalText,
            optionalLabel: optionalLabel,
            state: state,
            selectedIndex: selectedIndex,
            titles: titles,
            elements: elementsPlain,
            type: type
        )
    }

}
