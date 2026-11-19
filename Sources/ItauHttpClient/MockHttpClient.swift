//
//  MockHttpClient.swift
//  ItauHttpClient
//
//  Created by Sebastian Diaz Avila on 18-11-26.
//

import Foundation

public final class MockHttpClient: ItauHttpClientProtocol {
    public enum Scenario {
        case success
        case noInternet
        case statusCode(Int)
    }
    
    private let fileName: String
    private let bundle: Bundle
    private let scenario: Scenario
    private let delaySeconds: Int
    
    /// - bundle: el bundle donde está el JSON. Desde un feature se pasa `.module`.
    public init(fileName: String,
                bundle: Bundle,
                scenario: Scenario = .success,
                delaySeconds: Int = 1) {
        self.fileName = fileName
        self.bundle = bundle
        self.scenario = scenario
        self.delaySeconds = delaySeconds
    }
    
    public func request<T: Decodable>(_ endpoint: any ItauEndpointProtocol) async -> Result<T, APIError> {
        try? await Task.sleep(for: .seconds(delaySeconds))
        
        switch scenario {
        case .noInternet:
            return .failure(.notConnectedToInternet)
        case .statusCode(let code):
            return .failure(.requestFailedPckeCode(code))
        case .success:
            break
        }
        
        guard let url = bundle.url(forResource: fileName, withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            return .failure(.invalidData)
        }
        
        do {
            return .success(try JSONDecoder().decode(T.self, from: data))
        } catch {
            return .failure(.jsonParsingFailure)
        }
    }
}
