//
//  PrimaryButtonDTO.swift
//  ExampleiOS
//
//  Created by on 06.03.2022.
//

import Foundation

struct PrimaryButtonDTO: Decodable {
    let enabled: Bool
    let isIconEnabled: Bool?
    let isLoading: Bool
    let size: Int?
    let text: String?
}

extension PrimaryButtonDTO {

    func convertToPlain() -> PrimaryButtonPlain {
        PrimaryButtonPlain(
            enabled: enabled,
            isIconEnabled: isIconEnabled,
            isLoading: isLoading,
            size: size,
            text: text
        )
    }

}
