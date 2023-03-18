//
//  Cacheable.swift
//  StarWars
//
//  Created by Abdelrhman Elmahdy on 17/03/2023.
//

import Foundation

protocol Cacheable: Codable {
    var cacheKey: NSString { get }
}
