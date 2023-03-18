//
//  URL+Ext.swift
//  StarWars
//
//  Created by Abdelrhman Elmahdy on 16/03/2023.
//

import Foundation

extension URL {
    mutating func appendQueryItems(_ urlParameters: RemoteEndpoint.RequestParameters) {
        guard var urlComponents = URLComponents(string: absoluteString) else { return }

        let newQueryItems = urlParameters.map {
            URLQueryItem(
                name: $0.key,
                value: "\($0.value)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
            )
        }
        let existingQueryItems: [URLQueryItem] = urlComponents.queryItems ?? []

        urlComponents.queryItems = existingQueryItems + newQueryItems
        self = urlComponents.url!
    }
}
