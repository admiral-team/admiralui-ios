//
//  AdmiralGunAPIFacade.swift
//  ExampleiOS
//
//  Created by on 04.03.2022.
//

import Foundation
import Combine

@available(iOS 13.0, *)
final class AdmiralGunAPIFacade {

    // MARK: - Services

    private let networkService: NetworkServiceProtocol

    // MARK: - Initializer

    init(with networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }

}

@available(iOS 13.0, *)
extension AdmiralGunAPIFacade: AdmiralGunApiFacadeProtocol {

    func getList() -> AnyPublisher<GunItemsDTO, APIError> {
        networkService.send(request: AdmiralGunEndpoint.allItems, shouldPrintResponse: false)
            .eraseToAnyPublisher()
    }

}
