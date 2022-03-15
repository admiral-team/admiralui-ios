//
//  TabDTO.swift
//  ExampleiOS
//
//  Created by on 06.03.2022.
//

import Foundation

struct TabDTO: Decodable {
    let enabled: Bool
    let selectedIndex: Int
    let titles: [String]?
}

extension TabDTO {

    func convertToPlain() -> TabPlain {
        TabPlain(
            enabled: enabled,
            selectedIndex: selectedIndex,
            titles: titles
        )
    }

}
