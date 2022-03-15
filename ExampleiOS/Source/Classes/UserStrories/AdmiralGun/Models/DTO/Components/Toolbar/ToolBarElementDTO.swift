//
//  ElementDTO.swift
//  ExampleiOS
//
//  Created by on 05.03.2022.
//

import Foundation

struct ToolBarElementDTO: Decodable {
    let icon: String
    let title: String
}

extension ToolBarElementDTO {

    func convertToPlain() -> ToolBarElement {
        ToolBarElement(icon: icon, title: title)
    }

}
