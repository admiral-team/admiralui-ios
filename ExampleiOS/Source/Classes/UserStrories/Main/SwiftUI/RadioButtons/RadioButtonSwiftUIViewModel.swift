//
//  RadioButtonSwiftUIViewModel.swift
//  ExampleiOS
//
//  Created on 21.04.2022.
//

import AdmiralSwiftUI
import Combine
import SwiftUI

@available(iOS 14.0.0, *)
final class RadioButtonSwiftUIViewModel: ObservableObject {

    final class RadioButtonSection {

        // MARK: - Properties

        let title: String
        var buttons: [RadioButtonItem]

        // MARK: - Initializer

        init(title: String, buttons: [RadioButtonItem] = []) {
            self.title = title
            self.buttons = buttons
        }

        // MARK: Internal Methods

        func changeSelectionState(index: Int) {
            buttons.enumerated().forEach { buttonIndex, _ in
                buttons[buttonIndex].isSelected = index == buttonIndex ? true : false
            }
        }
    }

    struct RadioButtonItem: Hashable {
        let id = UUID().uuidString
        let checkState: CheckControlState
        let text: String
        var isSelected: Bool

        func hash(into hasher: inout Hasher) {
            hasher.combine(text)
            hasher.combine(checkState)
        }

        static func == (lhs: RadioButtonItem, rhs: RadioButtonItem) -> Bool {
            return lhs.id == rhs.id
        }
    }

    // MARK: - Published Properties

    @Published var isEnabledControlsState: Int = 0
    @Published var selectedIndex: (Int, Int)?
    @Published var items: [RadioButtonSection]

    // MARK: - Internal Properties

    var navigationTitle: String {
        "Radiobutton"
    }

    var tabsItems: [String] {
        ["Default", "Disabled"]
    }

    // MARK: - Private Properties

    private var cancellables = Set<AnyCancellable>()

    // MARK: - Initializer

    init() {
        items = [
            RadioButtonSection(title: "Default", buttons: [
                .init(checkState: .normal, text: "", isSelected: false),
                .init(checkState: .normal, text: "Text", isSelected: false)
            ]),
            RadioButtonSection(title: "Selected", buttons: [
                .init(checkState: .normal, text: "", isSelected: true),
                .init(checkState: .normal, text: "Text", isSelected: true)
            ]),
            RadioButtonSection(title: "Error", buttons: [
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
