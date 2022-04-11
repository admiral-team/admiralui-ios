//
//  InputChatViewModel.swift
//  ExampleiOS
//
//  Created on 27.01.2022.
//

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
                message: "Привет, какой у вас вопрос ?",
                time: dateTime,
                image: nil,
                didSelect: nil,
                header: nil,
                direction: .left,
                name: "Антон"
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
