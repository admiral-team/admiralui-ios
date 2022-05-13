//
//  SmallInformersViewModel.swift
//  ExampleiOS
//
//  Created on 05.05.2022.
//

import Foundation

final class SmallInformersViewModel {

    // MARK: - Constants
    private struct Constants {
        static let title: String = "Text Informer"
        // swiftlint:disable all
        static let description: String = "At breakpoint boundaries, mini units divide the screen into a fixed master grid, and multiples of mini units map to fluid grid column widths and row heights.divide the screen into a fixed master grid, and multiples of mini units map to fluid grid column widths and row heights."
        // swiftlint:enable all
    }

    // MARK: - Internal Properties

    var items: [SmallInformerViewItem]

    // MARK: - Initializer

    init() {
        items = [
            SmallInformerViewItem(headLine: "Default", title: Constants.description, style: .default),
            SmallInformerViewItem(headLine: "Success", title: Constants.title, style: .success),
            SmallInformerViewItem(headLine: "Attention", title: Constants.title, style: .attention, direction: .down),
            SmallInformerViewItem(headLine: "Error", title: Constants.title, style: .error)
        ]
    }

}
