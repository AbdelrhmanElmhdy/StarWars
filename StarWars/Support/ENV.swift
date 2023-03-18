//
//  ENV.swift
//  StarWars
//
//  Created by Abdelrhman Elmahdy on 15/03/2023.
//

import Foundation

struct ENV {
    enum Context: String {
        case run
        case test
        case release
    }

    static let context = Context(rawValue: ProcessInfo.processInfo.environment[.env.context] ?? "")
}
