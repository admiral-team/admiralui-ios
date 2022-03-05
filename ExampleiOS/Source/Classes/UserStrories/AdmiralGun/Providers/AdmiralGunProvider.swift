//
//  AdmiralGunProvider.swift
//  ExampleiOS
//
//  Created by on 05.03.2022.
//

import Combine
import Foundation

@available(iOS 13.0, *)
final class AdmiralGunProvider {

    // MARK: - Services

    private let admiralGunAPIFacade: AdmiralGunApiFacadeProtocol

    // MARK: - Properties

    private let queue = DispatchQueue(label: "admiral.gun", attributes: .concurrent)

    // MARK: - Initializer

    init(admiralGunAPIFacade: AdmiralGunApiFacadeProtocol = AdmiralGunAPIFacade()) {
        self.admiralGunAPIFacade = admiralGunAPIFacade
    }

}

@available(iOS 13.0, *)
extension AdmiralGunProvider: AdmiralGunProviderProtocol {

    func getList() -> AnyPublisher<GunItems, APIError> {
        admiralGunAPIFacade.getList()
            .subscribe(on: queue)
            .map { $0.convertToPlain() }
            .eraseToAnyPublisher()
    }

}
