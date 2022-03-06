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
    let parameters: GunTypeDTO

    private enum CodingKeys: String, CodingKey {
        case description
        case id
        case parameters
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.description = try container.decode(String.self, forKey: .description)
        self.id = try container.decode(String.self, forKey: .id)
        switch id {
        case "PrimaryButton":
            let primaryButton = try container.decode(PrimaryButtonDTO.self, forKey: .parameters)
            parameters = .primaryButtton(primaryButton)
        case "StandartTextfield":
            let stadartTextField = try container.decode(StandartTextFieldDTO.self, forKey: .parameters)
            parameters = .standartTextField(stadartTextField)
        case "Tab":
            let tab = try container.decode(TabDTO.self, forKey: .parameters)
            parameters = .tab(tab)
        case "Switcher":
            let switcher = try container.decode(SwitcherDTO.self, forKey: .parameters)
            parameters = .switcher(switcher)
        case "Toolbar":
            let toolbar = try container.decode(ToolbarDTO.self, forKey: .parameters)
            parameters = .toolBar(toolbar)
        default:
            let data = try container.decode(UnknownParametersDTO.self, forKey: .parameters)
            parameters = .unknown(data)
        }
    }

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
