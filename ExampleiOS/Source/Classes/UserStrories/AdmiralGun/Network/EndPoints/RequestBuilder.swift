//
//  RequestBuilder.swift
//  ExampleiOS
//
//  Created by Borisov Kirill on 04.03.2022.
//

import Foundation

protocol RequestBuilder {
    func asURLRequest() throws -> URLRequest
}
