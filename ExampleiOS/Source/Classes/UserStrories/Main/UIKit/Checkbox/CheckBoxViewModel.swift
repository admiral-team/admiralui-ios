//
//  CheckBoxViewModel.swift
//  ExampleiOS
//
//  Created on 12.05.2022.
//

import AdmiralUIKit
import Foundation

final class CheckBoxViewModel {

    struct CheckBoxesItem {
        let textCheckboxTitle: String
        var checkBoxesControlState: CheckControlState
        var isSelected: Bool
        let titleText: String
    }

    // MARK: - Internal Properties

    var items: [CheckBoxesItem]

    // MARK: - Initializer

    init() {
        items = [
            CheckBoxesItem(
                textCheckboxTitle: "Text",
                checkBoxesControlState: .normal,
                isSelected: false,
                titleText: "Default"
            ),
            CheckBoxesItem(
                textCheckboxTitle: "Text",
                checkBoxesControlState: .normal,
                isSelected: true,
                titleText: "Selected"
            ),
            CheckBoxesItem(
                textCheckboxTitle: "Text",
                checkBoxesControlState: .error,
                isSelected: false,
                titleText: "Error"
            )
        ]
    }

}
