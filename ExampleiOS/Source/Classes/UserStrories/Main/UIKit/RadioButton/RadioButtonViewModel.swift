//
//  RadioButtonViewModel.swift
//  ExampleiOS
//
//  Created on 12.05.2022.
//

import AdmiralUIKit
import Foundation

final class RadioButtonViewModel {

    struct RadioBoxesItem {
        let textCheckboxTitle: String
        var checkBoxesControlState: CheckControlState
        var isSelected: Bool
        let titleText: String
    }

    // MARK: - Internal Properties

    var items: [RadioBoxesItem]

    // MARK: - Initializer

    init() {
        items = [
            RadioBoxesItem(
                textCheckboxTitle: "Text",
                checkBoxesControlState: .normal,
                isSelected: false,
                titleText: "Default"
            ),
            RadioBoxesItem(
                textCheckboxTitle: "Text",
                checkBoxesControlState: .normal,
                isSelected: true,
                titleText: "Selected"
            ),
            RadioBoxesItem(
                textCheckboxTitle: "Text",
                checkBoxesControlState: .error,
                isSelected: false,
                titleText: "Error"
            )
        ]
    }

}
