//
//  NetworkServiceProtocol.swift
//  ExampleiOS
//
//  Created by Borisov Kirill on 04.03.2022.
//

import Combine
import Foundation

@available(iOS 13.0, *)
protocol NetworkServiceProtocol {
    func send<T: Decodable>(request: RequestBuilder, shouldPrintResponse: Bool) -> AnyPublisher<T, APIError>
}
