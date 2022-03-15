//
//  ParametersDTO.swift
//  ExampleiOS
//
//  Created by on 05.03.2022.
//

import Foundation

struct UnknownParametersDTO: Decodable {
    let type: Int?
}

extension UnknownParametersDTO {

    func convertToPlain() -> UnknownParameters {
        UnknownParameters(type: type)
    }

}
