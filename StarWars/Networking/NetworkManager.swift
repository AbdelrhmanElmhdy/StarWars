//
//  NetworkManager.swift
//  StarWars
//
//  Created by Abdelrhman Elmahdy on 15/03/2023.
//

import Combine
import Foundation
import Network

struct NetworkManager: NetworkManagerProtocol {
    static let monitor: NWPathMonitor = {
        let monitor = NWPathMonitor()

        monitor.pathUpdateHandler = { path in
            isConnected = path.status == .satisfied
        }

        return monitor
    }()

    static var isConnected = false

    private let sessionConfiguration: URLSessionConfiguration
    private let session: URLSession

    init(sessionConfiguration: URLSessionConfiguration = .default) {
        self.sessionConfiguration = sessionConfiguration
        session = URLSession(configuration: sessionConfiguration)
    }

    func executeRequest<T: Decodable>(_ endpoint: any RemoteEndpoint) -> AnyPublisher<T, NetworkRequestError> {
        var request: URLRequest
        do { request = try endpoint.getURLRequest(isConnected: Self.isConnected) }
        catch { return Fail(outputType: T.self, failure: NetworkRequestError.badRequest()).eraseToAnyPublisher() }

        return session.dataTaskPublisher(for: request)
            .tryMap { data, response in
                if let httpStatusCode = (response as? HTTPURLResponse)?.statusCode {
                    guard (200 ... 299) ~= httpStatusCode else {
                        throw NetworkRequestError.httpResponseError(statusCode: httpStatusCode)
                    }
                }
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                if let error = error as? NetworkRequestError { return error }
                return NetworkRequestError(error: error)
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

    private func parseDataIntoDictionary(data: Data) -> [String: Any]? {
        let json = try? JSONSerialization.jsonObject(with: data, options: [])
        let dictionary = json as? [String: Any]

        return dictionary
    }
}
