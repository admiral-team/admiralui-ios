//
//  GunItemComponent.swift
//  ExampleiOS
//
//  Created by Borisov Kirill on 05.03.2022.
//

enum GunItemComponent {
    case primaryButton
    case standartTextfield
    case tab
    case switcher
    case toolbar
    case unknown
}

extension GunItemComponent {

    static func getComponent(by id: String) -> Self {
        switch id {
        case "PrimaryButton":
            return .primaryButton
        case "StandartTextfield":
            return .standartTextfield
        case "Tab":
            return .tab
        case "Switcher":
            return .switcher
        case "Toolbar":
            return .toolbar
        default:
            return .unknown
        }
    }

}
