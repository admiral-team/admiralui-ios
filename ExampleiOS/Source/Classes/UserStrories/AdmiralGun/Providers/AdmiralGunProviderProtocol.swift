//
//  AdmiralGunProviderProtocol.swift
//  ExampleiOS
//
//  Created by Borisov Kirill on 05.03.2022.
//

import Combine
import Foundation

@available(iOS 13.0, *)
protocol AdmiralGunProviderProtocol {
    /**
     Запрос на получение список компонентов
     - Returns: Список компонентов
     */
    func getList() -> AnyPublisher<GunItems, APIError>
}
