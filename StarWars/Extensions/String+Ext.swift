//
//  String+Ext.swift
//  StarWars
//
//  Created by Abdelrhman Elmahdy on 15/03/2023.
//

import Foundation

// MARK: + Utilities

extension String {
    var localized: String { NSLocalizedString(self, comment: "") }
}

// MARK: + Static Texts

extension String {
    // swiftlint:disable:next identifier_name
    static let ui = UITextsContainer.self
    static let errors = ErrorTextsContainer.self
    static let colors = ColorNamesContainer.self
    static let files = FileNamesContainer.self
    static let env = EnvironmentVariableNamesContainer.self
}
