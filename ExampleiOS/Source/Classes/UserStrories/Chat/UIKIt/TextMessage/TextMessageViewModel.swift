//
//  TextMessageViewModel.swift
//  ExampleiOS
//
//  Created on 12.04.2022.
//

import AdmiralUIKit
import Foundation

final class TextMessageViewModel {

    // MARK: - Internal properties

    var chatMessages: [ChatMessageCellViewModel] = [
        ChatMessageCellViewModel(
            message: "Привет, какой у вас вопрос ?",
            time: "12:34",
            image: nil,
            didSelect: nil,
            header: nil,
            direction: .left,
            name: "Антон"
        ),
        ChatMessageCellViewModel(
            message: "Будем рады ответить !",
            time: "12:34",
            image: nil,
            didSelect: nil,
            header: nil,
            direction: .left,
            state: .error
        ),
        ChatMessageCellViewModel(
            message: "Повторная попытка отправки сообщения ?",
            time: "12:34",
            image: nil,
            didSelect: nil,
            header: nil,
            direction: .right,
            chatStatus: .sent
        ),
        ChatMessageCellViewModel(
            message: "Каким образом использовать ChatBubbleView ?",
            time: "12:34",
            image: nil,
            didSelect: nil,
            header: nil,
            direction: .right,
            chatStatus: .sent,
            state: .error
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
