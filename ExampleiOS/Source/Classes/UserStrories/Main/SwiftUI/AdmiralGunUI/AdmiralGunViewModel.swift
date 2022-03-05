//
//  AdmiralGunViewModel.swift
//  ExampleiOS
//
//  Created by Алмазов Иван Александрович on 04.03.2022.
//

import Combine
import AdmiralTheme
import AdmiralSwiftUI

@available(iOS 14.0.0, *)
final class AdmiralGunViewModel: ObservableObject {
    
    @Published var searchBarText: String? = ""
    @Published var isResponder = false
    @Published var items: [String] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        bindPublishers()
    }
    
    private func bindPublishers() {
        $searchBarText
            .dropFirst()
            .filterNil()
            .sink { searchText in
                guard !searchText.isEmpty else {
                    return
                }
                print(searchText)
            }
            .store(in: &cancellables)
    }
    
    
}
