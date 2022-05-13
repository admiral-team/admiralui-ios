//
//  HeadersBlockViewModel.swift
//  ExampleiOS
//
//  Created on 07.05.2022.
//

import AdmiralUIKit
import Foundation

final class HeadersBlockViewModel {

    struct HeaderView {
        let title: String
        let headerStyle: HeaderStyle
    }

    // MARK: - Internal Properties

    let items: [HeaderView]

    // MARK: - Initializer

    init() {
        items = [
            HeaderView(title: "Title 1", headerStyle: .title),
            HeaderView(title: "Subtitle 2", headerStyle: .body),
            HeaderView(title: "Headline", headerStyle: .headline),
            HeaderView(title: "Headline Secondary", headerStyle: .headlineSecondary)
        ]
    }

}
