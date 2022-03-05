//
//  APIError.swift
//  ExampleiOS
//
//  Created by on 04.03.2022.
//

enum APIError: Error {
    case decodingError
    case httpError(Int)
    case unknown
    case custom(String)
}
