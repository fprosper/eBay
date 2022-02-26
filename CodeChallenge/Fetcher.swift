import Foundation
import Combine

enum NetworkError: Error {
    case parsing(description: String)
    case network(description: String)
    case other(description: String)
}

protocol Fetchable {
    func fetchAd(withId id: String) -> AnyPublisher<Ad, NetworkError>
}

// MARK: -
class Fetcher {
    private let user = "candidate"
    private let password = "yx6Xz62y"
    private let baseURL = "https://gateway.ebay-kleinanzeigen.de/"

    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }
}

// MARK: - Fetchable
extension Fetcher: Fetchable {
    func fetchAd(withId id: String) -> AnyPublisher<Ad, NetworkError> {
        return publisher(withId: id)
    }
}

// MARK: -
extension Fetcher {
    /// Generics publisher for REST API requests
    private func publisher<T>(withId id: String) -> AnyPublisher<T, NetworkError> where T: Decodable {
        // let´s ensure we have a valid URL
        let urlString = "\(baseURL)/mobile-api/candidate/ads/\(id)"
        guard let url = URL(string: urlString) else  {
            let error: NetworkError = .network(description: "")
            return Fail(error: error)
            .eraseToAnyPublisher()
        }

        print("URLRequest: \(url.absoluteString)")

        /* URL request */
        var request = URLRequest(url: url)
        // basic authentication header
        let authData = (user + ":" + password).data(using: .utf8)!.base64EncodedString()
        request.addValue("Basic \(authData)", forHTTPHeaderField: "Authorization")
        // perform request
        return session
            .dataTaskPublisher(for: request)
            .mapError { error in
            .network(description: error.localizedDescription)
            }
            .flatMap(maxPublishers: .max(1)) { pair in
                decode(pair.data)
            }
            .eraseToAnyPublisher()
    }
   
}

// MARK: -
func decode<T: Decodable>(_ data: Data) -> AnyPublisher<T, NetworkError> {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .secondsSince1970
    return Just(data)
        .decode(type: T.self, decoder: decoder)
        .mapError { error in
        .parsing(description: error.localizedDescription)
        }.eraseToAnyPublisher()
}
