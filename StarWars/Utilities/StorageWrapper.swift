//
//  StorageWrapper.swift
//  StarWars
//
//  Created by Abdelrhman Elmahdy on 15/03/2023.
//

import Foundation

/// Store and retrieve any codable value using user defaults storage.
@propertyWrapper
struct Storage<T: Codable> {
    private let key: String
    private let defaultValue: T

    init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }

    var wrappedValue: T {
        get {
            // Retrieve the value stored for the specified key, or return the default value.
            guard let data = UserDefaults.standard.object(forKey: key) as? Data else {
                return defaultValue
            }

            let value = try? JSONDecoder().decode(T.self, from: data)
            return value ?? defaultValue
        }
        set {
            // Encode the object into data, and store it with the specified key.
            let data = try? JSONEncoder().encode(newValue)
            UserDefaults.standard.set(data, forKey: key)
            UserDefaults.standard.synchronize()
        }
    }
}
