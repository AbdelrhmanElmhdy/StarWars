//
//  GenericError.swift
//  StarWars
//
//  Created by Abdelrhman Elmahdy on 15/03/2023.
//

import Foundation

enum GenericError: UserFriendlyError {
    case somethingWentWrong(debugDescription: String,
                            userFriendlyDescription: String? = nil,
                            userFriendlyRecoverySuggestion: String? = nil,
                            isFatal: Bool = false)

    var associatedValues: (debugDescription: String, userFriendlyDescription: String, userFriendlyRecoverySuggestion: String, isFatal: Bool) {
        switch self {
        case let .somethingWentWrong(description, userFriendlyDescription, userFriendlyRecoverySuggestion, isFatal):
            return (description,
                    userFriendlyDescription ?? defaultUserFriendlyDescription,
                    userFriendlyRecoverySuggestion ?? defaultUserFriendlyRecoverySuggestion,
                    isFatal)
        }
    }
}
