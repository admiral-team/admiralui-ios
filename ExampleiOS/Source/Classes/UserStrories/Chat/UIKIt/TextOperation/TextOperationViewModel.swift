//
//  TextOperationViewModel.swift
//  ExampleiOS
//
//  Created on 27.01.2022.
//

import AdmiralUIKit
import Foundation

final class TextOperationViewModel {

    // MARK: - Internal properties

    var textOperations: [TextOperationCellViewModel] = [
        TextOperationCellViewModel(
            title: "+ 35 000 ₽",
            description: "НПО «Ромашка»",
            time: "13 мая 14:15",
            didSelect: nil,
            direction: .left,
            chatStatus: .none,
            style: .default,
            titleLabelText: "Default",
            chatBubbleTime: "21:21"
        ),
        TextOperationCellViewModel(
            title: "+ 35 000 ₽",
            description: "НПО «Ромашка»",
            time: "13 мая 14:15",
            didSelect: nil,
            direction: .left,
            chatStatus: .none,
            style: .success,
            titleLabelText: "Success",
            chatBubbleTime: "21:21"
        ),
        TextOperationCellViewModel(
            title: "+ 35 000 ₽",
            description: "НПО «Ромашка»",
            time: "13 мая 14:15",
            didSelect: nil,
            direction: .left,
            chatStatus: .none,
            style: .error,
            titleLabelText: "Error",
            chatBubbleTime: "21:21"
        )
    ]

    var sections: [MainSectionViewModel] {
        [MainSectionViewModel(items: textOperations)]
    }
    
}
