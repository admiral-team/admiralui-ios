//
//  CheckBoxSwiftUIViewModel.swift
//  ExampleiOS
//
//  Created on 22.04.2022.
//

import AdmiralSwiftUI
import Combine
import SwiftUI

@available(iOS 14.0.0, *)
final class CheckBoxSwiftUIViewModel: ObservableObject {

    final class CheckBoxSection {

        // MARK: - Properties

        let title: String
        var checkBoxs: [CheckBoxItem]

        // MARK: - Initializer

        init(title: String, checkBoxs: [CheckBoxItem] = []) {
            self.title = title
            self.checkBoxs = checkBoxs
        }

        // MARK: Internal Methods

        func changeSelectionState(index: Int) {
            checkBoxs[index].isSelected.toggle()
        }
    }

    struct CheckBoxItem: Hashable {
        let id = UUID().uuidString
        let checkState: CheckControlState
        let text: String
        var isSelected: Bool

        func hash(into hasher: inout Hasher) {
            hasher.combine(text)
            hasher.combine(checkState)
        }

        static func == (lhs: CheckBoxItem, rhs: CheckBoxItem) -> Bool {
            return lhs.id == rhs.id
        }
    }

    // MARK: - Published Properties

    @Published var isEnabledControlsState: Int = 0
    @Published var selectedIndex: (Int, Int)?
    @Published var items: [CheckBoxSection]

    // MARK: - Internal Properties

    var navigationTitle: String {
        "Checkbox"
    }

    var tabsItems: [String] {
        ["Default", "Disabled"]
    }

    // MARK: - Private Properties

    private var cancellables = Set<AnyCancellable>()

    // MARK: - Initializer

    init() {
        items = [
            CheckBoxSection(title: "Default", checkBoxs: [
                .init(checkState: .normal, text: "", isSelected: false),
                .init(checkState: .normal, text: "Text", isSelected: false)
            ]),
            CheckBoxSection(title: "Selected", checkBoxs: [
                .init(checkState: .normal, text: "", isSelected: true),
                .init(checkState: .normal, text: "Text", isSelected: true)
            ]),
            CheckBoxSection(title: "Error", checkBoxs: [
                .init(checkState: .error, text: "", isSelected: false),
                .init(checkState: .error, text: "Text", isSelected: false)
            ])
        ]
        bindPublishers()
    }

    // MARK: - Binding

    private func bindPublishers() {
        $selectedIndex
            .filterNil()
            .sink { [weak self] index in
                self?.items[index.0].changeSelectionState(index: index.1)
            }
            .store(in: &cancellables)
    }

}
