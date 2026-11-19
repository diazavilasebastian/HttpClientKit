//
//  APIError.swift
//  ItauHttpClient
//
//  Created by Sebastian Diaz Avila on 18-11-26.
//

public enum APIError: Error, Equatable {
    case invalidURL
    case requestTimeout
    case notConnectedToInternet
    case responseUnsuccessful
    case requestFailedPckeCode(Int)
    case invalidData
    case jsonParsingFailure
}

