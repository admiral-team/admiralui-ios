//
//  StandartTextFieldDTO.swift
//  ExampleiOS
//
//  Created by on 06.03.2022.
//

import Foundation

struct StandartTextFieldDTO: Decodable {
    let enabled: Bool
    let additionalText: String?
    let isIconEnabled: Bool?
    let optionalLabel: String?
    let state: Int?
    let text: String?
}

extension StandartTextFieldDTO {

    func convertToPlain() -> StandartTextFieldPlain {
        StandartTextFieldPlain(
            enabled: enabled,
            additionalText: additionalText,
            isIconEnabled: isIconEnabled,
            optionalLabel: optionalLabel,
            state: state,
            text: text
        )
    }

}
