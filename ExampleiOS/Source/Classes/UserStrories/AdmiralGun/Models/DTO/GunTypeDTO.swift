//
//  GunTypeDTO.swift
//  ExampleiOS
//
//  Created by on 06.03.2022.
//

import Foundation

enum GunTypeDTO {
    case primaryButtton(PrimaryButtonDTO)
    case unknown(UnknownParametersDTO)
    case standartTextField(StandartTextFieldDTO)
    case tab(TabDTO)
    case switcher(SwitcherDTO)
    case toolBar(ToolbarDTO)
}

extension GunTypeDTO {

    func convertToPlain() -> GunType {
        switch self {
        case .primaryButtton(let primaryButtonDTO):
            return  .primaryButtton(primaryButtonDTO.convertToPlain())
        case .unknown(let paramsDTO):
            return .unknown(paramsDTO.convertToPlain())
        case .standartTextField(let standartTextFieldDTO):
            return .standartTextField(standartTextFieldDTO.convertToPlain())
        case .tab(let tabDTO):
            return .tab(tabDTO.convertToPlain())
        case .switcher(let switcherDTO):
            return .switcher(switcherDTO.convertToPlain())
        case .toolBar(let toolBarDTO):
            return .toolBar(toolBarDTO.convertToPlain())
        }
    }

}
