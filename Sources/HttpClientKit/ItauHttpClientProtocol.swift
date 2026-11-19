//
//  Untitled.swift
//  ItauHttpClient
//
//  Created by Sebastian Diaz Avila on 18-11-26.
//

public protocol ItauHttpClientProtocol {
    func request<T: Decodable>(_ endpoint: any ItauEndpointProtocol) async -> Result<T, APIError>
}

