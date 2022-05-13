//
//  BigInformersViewModel.swift
//  ExampleiOS
//
//  Created on 06.05.2022.
//

import Foundation

final class BigInformersViewModel {

    private enum InformerState: Int {
        case enabled
        case disabled
    }

    // MARK: - Constants

    private struct Constants {
        static let title: String = "Headline"
        // swiftlint:disable all
        static let description: String = "At breakpoint boundaries, mini units divide the screen into a fixed master grid, and multiples of mini units map to fluid grid column widths and row heights."
        // swiftlint:enable all
        static let linkText: String = "Link text"
    }

    // MARK: - Internal Properties

    var items: [InformerModel]

    // MARK: - Initializer

    init() {
        items = [
            BigInformerViewViewModel(
                headLine: "Default",
                title: Constants.title,
                description: Constants.description,
                linkLabel: Constants.linkText,
                style: .default),
            BigInformerViewViewModel(
                headLine: "Success",
                title: Constants.title,
                description: Constants.description,
                linkLabel: Constants.linkText,
                style: .success),
            BigInformerViewViewModel(
                headLine: "Attention",
                title: Constants.title,
                description: Constants.description,
                linkLabel: Constants.linkText,
                style: .attention),
            BigInformerViewViewModel(
                headLine: "Error",
                title: Constants.title,
                description: Constants.description,
                linkLabel: Constants.linkText,
                style: .error),
            MessageInformerViewViewModel(
                headLine: "Message view",
                title: "то получу в страховом случае",
                description: "до 1 500 000 Р",
                subtitle: "Выгодный вариант для двухкомнатной квартиры или дачного дома"
            )
        ]
    }

}
