//
//  CacheFetchingService.swift
//  StarWars
//
//  Created by Abdelrhman Elmahdy on 17/03/2023.
//

import Combine
import Foundation

protocol CachingService: AnyObject {
    associatedtype ServicedType: Cacheable, Codable
    var cache: NSCache<NSString, NSData> { get }

    func fetchFromCache(forKey key: NSString) -> ServicedType?
    func storeInCache(_ value: ServicedType)
}

extension CachingService {
    func fetchFromCache(forKey key: NSString) -> ServicedType? {
        guard let data = cache.object(forKey: key) else { return nil }
        return try? JSONDecoder().decode(ServicedType.self, from: Data(referencing: data))
    }

    func storeInCache(_ value: ServicedType) {
        guard let data = try? JSONEncoder().encode(value) else { return }
        cache.setObject(NSData(data: data), forKey: value.cacheKey)
    }
}
