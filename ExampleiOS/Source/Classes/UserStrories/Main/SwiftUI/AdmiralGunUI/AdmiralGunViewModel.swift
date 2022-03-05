//
//  AdmiralGunViewModel.swift
//  ExampleiOS
//
//  Created by on 04.03.2022.
//

import Combine
import AdmiralTheme
import AdmiralSwiftUI

@available(iOS 14.0.0, *)
final class AdmiralGunViewModel: ObservableObject {

    enum State {
        case loading
        case error
        case `default`
    }

    // MARK: - Published Properties

    @Published var searchBarText: String? = ""
    @Published var isResponder = false
    @Published var state: State = .loading
    @Published var items: [GunItem] = []

    // MARK: - Properties

    private let provider: AdmiralGunProviderProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(provider: AdmiralGunProviderProtocol) {
        self.provider = provider
        bindPublishers()
    }
    
    private func bindPublishers() {
        provider
            .getList()
            .subscribe(on: DispatchQueue.main)
            .sink(
                receiveFailure: { [weak self] _ in
                    self?.state = .error
                },
                receiveValue: { [weak self] data in
                    self?.state = .default
                    self?.items = data.items
                }
            )
            .store(in: &cancellables)

        $searchBarText
            .dropFirst()
            .filterNil()
            .sink { searchText in
                guard !searchText.isEmpty else {
                    return
                }
            }
            .store(in: &cancellables)
    }


}
