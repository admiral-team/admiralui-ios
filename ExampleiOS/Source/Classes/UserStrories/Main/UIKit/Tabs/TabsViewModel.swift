//
//  TabsViewModel.swift
//  ExampleiOS
//
//  Created on 07.05.2022.
//

import Foundation

final class TabsViewModel {

    enum Items: CaseIterable {
        case standart
        case logo
        case informer
        case outline
        case underline
        case icon

        func getTitle() -> String {
            switch self {
            case .standart:
                return "Standard Tabs"
            case .logo:
                return "Logo Tabs"
            case .informer:
                return "Informer Tabs"
            case .outline:
                return "Outline Slider Tabs"
            case .underline:
                return "Underline Slider Tabs"
            case .icon:
                return "Icon Tabs"
            }
        }
    }

    // MARK: - Internal properties

    var items: [Items] {
        Items.allCases
    }

}
