//
//  TabsSwiftUIViewModel.swift
//  ExampleiOS
//
//  Created on 27.04.2022.
//

import Combine

@available(iOS 14.0.0, *)
final class TabsSwiftUIViewModel: ObservableObject {

    enum TabsSwiftUIItem: Int, CaseIterable {
        case standard
        case logo
        case informer
        case outlineSlider
        case underlineSlider
        case icon

        var title: String {
            switch self {
            case .standard:
                return "Standard Tabs"
            case .logo:
                return "Logo Tabs"
            case .informer:
                return "Informer Tabs"
            case .outlineSlider:
                return "Outline Slider Tabs"
            case .underlineSlider:
                return "Underline Slider Tabs"
            case .icon:
                return "Icon Tabs"
            }
        }
    }

    // MARK: - Published Properties

    @Published var selection: Int?

    // MARK: - Internal Properties

    var title: String {
        "Tabs"
    }

}
