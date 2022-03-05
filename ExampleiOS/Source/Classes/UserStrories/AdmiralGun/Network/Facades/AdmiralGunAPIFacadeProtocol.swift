//
//  AdmiralGunApiFacadeProtocol.swift
//  ExampleiOS
//
//  Created by Borisov Kirill on 04.03.2022.
//

import Combine
import Foundation

@available(iOS 13.0, *)
protocol AdmiralGunApiFacadeProtocol {
    /**
     Создает запрос на получение списка элементов
     - Returns: Паблишер, который содержит:
        - Объект, содержащий массив обращений
        - В случае неуспеха возвращает ошибку
     */
    func getList() -> AnyPublisher<GunItemsDTO, APIError>
}
