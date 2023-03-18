//
//  JSONFileLoader.swift
//  StarWars
//
//  Created by Abdelrhman Elmahdy on 15/03/2023.
//

import Foundation
struct JSONFileLoader {
    static func loadJsonData(fromFile fileName: String) -> Data? {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else { return nil }

        do {
            let data = try Data(contentsOf: url)
            return data
        } catch {
            return nil
        }
    }

    static func loadJson<T: Decodable>(as type: T.Type, fromFile fileName: String) -> T? {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else { return nil }

        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            return nil
        }
    }
}
