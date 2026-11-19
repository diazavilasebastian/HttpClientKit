//
//  ItauEndpointProtocol.swift
//  ItauHttpClient
//
//  Created by Sebastian Diaz Avila on 18-11-26.
//

import Foundation

public protocol ItauEndpointProtocol {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var method: APIMethod { get }
    var headers: [String: String]? { get }
}

public extension ItauEndpointProtocol {
    var urlRequest: URLRequest? {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path
        
        guard let url = components.url else { return nil }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        headers?.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }
        return request
    }
}
