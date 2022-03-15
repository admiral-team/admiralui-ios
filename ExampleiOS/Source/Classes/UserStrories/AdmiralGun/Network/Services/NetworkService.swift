//
//  NetworkService.swift
//  ExampleiOS
//
//  Created by on 04.03.2022.
//

import Combine
import Foundation

@available(iOS 13.0, *)
final class NetworkService: NetworkServiceProtocol {

    func send<T: Decodable>(request: RequestBuilder, shouldPrintResponse: Bool = false) -> AnyPublisher<T, APIError> {
        APIPublisher(builder: request, shouldPrintResponse: shouldPrintResponse)
            .eraseToAnyPublisher()
    }

}
