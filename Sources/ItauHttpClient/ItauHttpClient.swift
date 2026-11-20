// The Swift Programming Language
// https://docs.swift.org/swift-book
import Foundation

public final class ItauHttpClient: ItauHttpClientProtocol {
    private let session: URLSession
    
    public init(session: URLSession = .shared) {
        self.session = session
    }
    
    public func result<T: Decodable>(urlRequest: URLRequest?, decoder: JSONDecoder?) async -> Result<T, APIError> {
        guard let urlRequest else {
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
                return .success(try (decoder ?? JSONDecoder()).decode(T.self, from: data))
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
