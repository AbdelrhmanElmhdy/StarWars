//
//  RemoteEndpoint.swift
//  StarWars
//
//  Created by Abdelrhman Elmahdy on 15/03/2023.
//

import Foundation

protocol RemoteEndpoint {
    typealias RequestParameters = [String: any Encodable]
    typealias HTTPHeaders = [String: String]

    var baseUrl: URL { get }
    var path: String { get }
    var url: URL? { get }
    var httpMethod: HTTPMethod { get }
    var bodyParameters: RequestParameters? { get }
    var urlParameters: RequestParameters? { get }
    var headers: HTTPHeaders? { get }
    var connectedCachePolicy: URLRequest.CachePolicy { get }
    var noConnectionCachePolicy: URLRequest.CachePolicy { get }

    func getURLRequest(isConnected: Bool) throws -> URLRequest
}

extension RemoteEndpoint {
    var url: URL? { URL(string: path, relativeTo: baseUrl) }

    func getURLRequest(isConnected: Bool) throws -> URLRequest {
        try buildRequest(isConnected: isConnected)
    }

    private func buildRequest(isConnected: Bool) throws -> URLRequest {
        guard let url = url else {
            throw NetworkRequestError.invalidURL(debugDescription: "Invalid URL: \(baseUrl)\(path)")
        }

        var request = URLRequest(url: url, timeoutInterval: 10.0)

        // Set the http method
        request.httpMethod = httpMethod.rawValue

        // Set the url parameters
        if let urlParameters = urlParameters {
            request.url?.appendQueryItems(urlParameters)
        }

        // Set the body parameters
        if let bodyParameters = bodyParameters {
            request.httpBody = try JSONSerialization.data(withJSONObject: bodyParameters)
        }

        // Set the headers
        if let headers = headers {
            setRequestHeaders(headers, in: &request)
        }

        request.cachePolicy = isConnected ? connectedCachePolicy : noConnectionCachePolicy
        request.timeoutInterval = 25

        return request
    }

    private func setRequestHeaders(_ headers: HTTPHeaders, in request: inout URLRequest) {
        for (headerField, value) in headers {
            request.setValue(value, forHTTPHeaderField: headerField)
        }
    }
}
