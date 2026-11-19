//
//  URLSessionHttpClient.swift
//  ItauHttpClient
//
//  Created by Sebastian Diaz Avila on 18-11-26.
//

import Foundation

public final class URLSessionHttpClient: ItauHttpClientProtocol {
    private let session: URLSession
    private let decoder: JSONDecoder
    
    public init(session: URLSession = .shared, decoder: JSONDecoder = JSONDecoder()) {
        self.session = session
        self.decoder = decoder
    }
    
    public func request<T: Decodable>(_ endpoint: any ItauEndpointProtocol) async -> Result<T, APIError> {
        guard let urlRequest = endpoint.urlRequest else {
            return .failure(.invalidURL)
        }
        
        do {
            let (data, response) = try await session.data(for: urlRequest)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                return .failure(.responseUnsuccessful)
            }
            guard (200...299).contains(httpResponse.statusCode) else {
                return .failure(.requestFailedPckeCode(httpResponse.statusCode))
            }
            
            do {
                return .success(try decoder.decode(T.self, from: data))
            } catch {
                return .failure(.jsonParsingFailure)
            }
        } catch let error as URLError {
            switch error.code {
            case .timedOut:
                return .failure(.requestTimeout)
            case .notConnectedToInternet, .networkConnectionLost:
                return .failure(.notConnectedToInternet)
            default:
                return .failure(.responseUnsuccessful)
            }
        } catch {
            return .failure(.responseUnsuccessful)
        }
    }
}

