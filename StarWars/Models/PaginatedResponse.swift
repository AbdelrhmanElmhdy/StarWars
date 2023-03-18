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
}
