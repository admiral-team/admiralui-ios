//
//  CustomSwiftUIViewModel.swift
//  ExampleiOS
//
//  Created on 30.12.2021.
//

import AdmiralSwiftUI
import AdmiralNotificationsSwiftUI
import Combine

@available(iOS 14.0.0, *)
final class CustomSwiftUIViewModel: ObservableObject {

    @Published var searchBarText: String? = ""
    @Published var toastDirection: ToastNotificationsDirection = .up
    @Published var filteredItems = SwiftUIItem.allCases
    @Published var isResponder = false

    private var cancellables = Set<AnyCancellable>()

    init() {
        bindPublishers()
    }

    private func bindPublishers() {
        $searchBarText
            .dropFirst()
            .filterNil()
            .sink { [weak self] searchText in
                let textWithoutSpaces = searchText.trimmingCharacters(in: .whitespaces)
                guard !textWithoutSpaces.isEmpty else {
                    self?.filteredItems = SwiftUIItem.allCases
                    return
                }
                
                self?.filteredItems = SwiftUIItem.allCases.filter {
                    $0.rawValue.lowercased().contains(textWithoutSpaces.lowercased())
                }
            }
            .store(in: &cancellables)
    }

}
