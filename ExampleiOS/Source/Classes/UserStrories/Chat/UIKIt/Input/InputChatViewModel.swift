//
//  InputChatViewModel.swift
//  ExampleiOS
//
//  Created on 27.01.2022.
//
// swiftlint:disable all

import Foundation

final class InputChatViewModel {

    // MARK: - Private properties

    private let dateTime: String = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: Date())
    }()

    // MARK: - Internal properties

    var messages: [ChatMessageCellViewModel]

    var sections: [MainSectionViewModel] {
        [MainSectionViewModel(items: messages)]
    }

    // MARK: - Initializer

    init() {
        messages = [
            ChatMessageCellViewModel(
                message: "At breakpoint boundaries, mini units divide",
                time: "14:52",
                image: nil,
                didSelect: nil,
                header: nil,
                direction: .left
            ),
            ChatMessageCellViewModel(
                message: "Text message",
                time: "14:52",
                image: nil,
                didSelect: nil,
                header: nil,
                direction: .left
            ),
            ChatMessageCellViewModel(
                message: "At breakpoint boundaries, miniunits divide the screen into a fixed master grid, and multiples of mini units map to fluid grid column widths and row heights.",
                time: "14:52",
                image: nil,
                didSelect: nil,
                header: nil,
                direction: .right,
                chatStatus: .loading
            )
        ]
    }

    // MARK: - Internal methods

    func addMessage(_ text: String?) {
        guard let text = text,
              !text.isEmpty else {
            return
        }

        let message = ChatMessageCellViewModel(
            message: text,
            time: dateTime,
            image: nil,
            didSelect: nil,
            header: nil,
            direction: .right,
            chatStatus: .read
        )
        messages.append(message)
    }

}
