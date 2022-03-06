//
//  SwitcherDTO.swift
//  ExampleiOS
//
//  Created by on 06.03.2022.
//

import Foundation

struct SwitcherDTO: Decodable {
    let enabled: Bool
}

extension SwitcherDTO {

    func convertToPlain() -> SwitcherPlain {
        SwitcherPlain(enabled: enabled)
    }

}
