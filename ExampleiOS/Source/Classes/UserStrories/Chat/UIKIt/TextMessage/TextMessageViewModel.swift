//
//  TextMessageViewModel.swift
//  ExampleiOS
//
//  Created on 12.04.2022.
//
// swiftlint:disable all

import AdmiralUIKit
import Foundation

final class TextMessageViewModel {

    // MARK: - Internal properties

    var chatMessages: [ChatMessageCellViewModel] = [
        ChatMessageCellViewModel(
            message: "Hello",
            time: "14:52",
            image: nil,
            didSelect: nil,
            header: nil,
            direction: .right,
            chatStatus: .read
        ),
        ChatMessageCellViewModel(
            message: "At breakpoint boundaries, miniunits divide the screen into a fixed master grid, and multiples of mini units map to fluid grid column widths and row heights.",
            time: "14:52",
            image: nil,
            didSelect: nil,
            header: nil,
            direction: .right,
            chatStatus: .loading
        ),
        ChatMessageCellViewModel(
            message: "At breakpoint boundaries, mini units divide",
            time: "14:52",
            image: nil,
            didSelect: nil,
            header: nil,
            direction: .left,
            name: "Татьяна"
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
            direction: .right
        )
    ]

    var sections: [MainSectionViewModel] {
        [MainSectionViewModel(items: chatMessages)]
    }

    // MARK: - Internal Methods

    func removeMessage(by index: Int) {
        chatMessages.remove(at: index)
    }

    func changeMessageStatus(
        with state: ChatBubbleState,
        status: ChatStatus = .read,
        index: Int
    ) {
        chatMessages[index].state = state
        chatMessages[index].chatStatus = status
    }

}
