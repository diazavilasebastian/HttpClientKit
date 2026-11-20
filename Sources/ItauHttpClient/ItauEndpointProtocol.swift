//
//  ItauEndpointProtocol.swift
//  ItauHttpClient
//
//  Created by Sebastian Diaz Avila on 18-11-26.
//
import Foundation

public protocol ItauEndpointProtocol {
    var scheme: APIScheme { get }        // antes: String
    var host: String { get }
    var router: String { get }           // antes: path
    var method: APIMethod { get }
    var headers: HTTPHeaders? { get }    // antes: [String: String]?
}

public extension ItauEndpointProtocol {
    var urlRequest: URLRequest? {
        var components = URLComponents()
        components.scheme = scheme.rawValue   // antes: scheme
        components.host = host
        components.path = router              // antes: path
        
        guard let url = components.url else { return nil }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        headers?.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }
        return request
    }
}
