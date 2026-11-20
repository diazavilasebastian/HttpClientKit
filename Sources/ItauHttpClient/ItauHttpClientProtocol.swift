//
//  Untitled.swift
//  ItauHttpClient
//
//  Created by Sebastian Diaz Avila on 18-11-26.
//
import Foundation

public protocol ItauHttpClientProtocol {
    /// - decoder: `nil` usa un `JSONDecoder()` por defecto.
    func result<T: Decodable>(urlRequest: URLRequest?, decoder: JSONDecoder?) async -> Result<T, APIError>
}
