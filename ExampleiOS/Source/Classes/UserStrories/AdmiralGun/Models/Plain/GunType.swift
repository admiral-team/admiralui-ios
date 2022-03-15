//
//  GunType.swift
//  ExampleiOS
//
//  Created by on 06.03.2022.
//

import Foundation

enum GunType: Hashable {
    case primaryButtton(PrimaryButtonPlain)
    case standartTextField(StandartTextFieldPlain)
    case tab(TabPlain)
    case unknown(UnknownParameters)
    case switcher(SwitcherPlain)
    case toolBar(ToolBarPlain)
}
