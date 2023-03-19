//
//  PaginatedResponse.swift
//  StarWars
//
//  Created by Abdelrhman Elmahdy on 16/03/2023.
//

import Foundation

struct PaginatedResponse<ResponseType: Codable>: Codable {
    let count: Int
    let next: URL?
    let previous: URL?
    let results: [ResponseType]

    var nextPage: Int? {
        guard let next = next else { return nil }
        let urlComponents = URLComponents(url: next, resolvingAgainstBaseURL: true)

        guard let stringPage = urlComponents?.queryItems?.first(where: { $0.name == "page" })?.value else {
            return nil
        }

        return Int(stringPage)
    }
}
