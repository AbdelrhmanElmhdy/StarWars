//
//  NetworkRequestError.swift
//  StarWars
//
//  Created by Abdelrhman Elmahdy on 15/03/2023.
//

import Foundation

enum NetworkRequestError: UserFriendlyError {
    init(error: Error) {
        if let error = error as? DecodingError {
            self = .failedToDecode(debugDescription: String(describing: error))
            return
        }

        if let error = error as? URLError {
            switch error.code {
            case .notConnectedToInternet, .networkConnectionLost, .dataNotAllowed:
                self = .failedToConnectToInternet(debugDescription: String(describing: error))
            case .timedOut:
                self = .requestTimedOut(debugDescription: String(describing: error))
            default:
                self = .somethingWentWrong(debugDescription: String(describing: error))
            }

            return
        }

        self = .somethingWentWrong(debugDescription: String(describing: error))
    }

    case somethingWentWrong(debugDescription: String,
                            userFriendlyDescription: String? = nil,
                            userFriendlyRecoverySuggestion: String? = nil,
                            isFatal: Bool = true)

    case failedToConnectToInternet(debugDescription: String = "Failed to connect to internet",
                                   userFriendlyDescription: String? = .errors.requestTimedOut,
                                   userFriendlyRecoverySuggestion: String? = .errors.checkInternetConnectionAdvice,
                                   isFatal: Bool = false)

    case requestTimedOut(debugDescription: String = "Request timed out",
                         userFriendlyDescription: String? = .errors.requestTimedOut,
                         userFriendlyRecoverySuggestion: String? = .errors.checkInternetConnectionAdvice,
                         isFatal: Bool = false)

    case failedToDecode(debugDescription: String,
                        userFriendlyDescription: String? = nil,
                        userFriendlyRecoverySuggestion: String? = nil,
                        isFatal: Bool = true)

    case failedToEncode(debugDescription: String,
                        userFriendlyDescription: String? = nil,
                        userFriendlyRecoverySuggestion: String? = nil,
                        isFatal: Bool = true)

    case invalidURL(debugDescription: String,
                    userFriendlyDescription: String? = nil,
                    userFriendlyRecoverySuggestion: String? = nil,
                    isFatal: Bool = true)

    case badRequest(debugDescription: String = "Bad request",
                    userFriendlyDescription: String? = nil,
                    userFriendlyRecoverySuggestion: String? = nil,
                    isFatal: Bool = true)

    case httpResponseError(statusCode: Int)

    var associatedValues: (debugDescription: String, userFriendlyDescription: String, userFriendlyRecoverySuggestion: String, isFatal: Bool) {
        switch self {
        case let .somethingWentWrong(debugDescription, userFriendlyDescription, userFriendlyRecoverySuggestion, isFatal),
             let .failedToConnectToInternet(debugDescription, userFriendlyDescription, userFriendlyRecoverySuggestion, isFatal),
             let .requestTimedOut(debugDescription, userFriendlyDescription, userFriendlyRecoverySuggestion, isFatal),
             let .failedToDecode(debugDescription, userFriendlyDescription, userFriendlyRecoverySuggestion, isFatal),
             let .failedToEncode(debugDescription, userFriendlyDescription, userFriendlyRecoverySuggestion, isFatal),
             let .invalidURL(debugDescription, userFriendlyDescription, userFriendlyRecoverySuggestion, isFatal),
             let .badRequest(debugDescription, userFriendlyDescription, userFriendlyRecoverySuggestion, isFatal):
            return (debugDescription,
                    userFriendlyDescription ?? defaultUserFriendlyDescription,
                    userFriendlyRecoverySuggestion ?? defaultUserFriendlyRecoverySuggestion,
                    isFatal)

        case let .httpResponseError(statusCode):
            return getStatusCodeErrorAssociatedValues(statusCode)
        }
    }

    private func getStatusCodeErrorAssociatedValues(_ statusCode: Int)
        -> (debugDescription: String,
            userFriendlyDescription: String,
            userFriendlyRecoverySuggestion: String,
            isFatal: Bool) {
        var statusCodeDescription = "statusCode: \(statusCode) "
        var userFriendlyDescription = defaultUserFriendlyDescription
        var userFriendlyRecoverySuggestion: String = defaultUserFriendlyRecoverySuggestion
        var isFatal = false

        switch statusCode {
        case 401:
            statusCodeDescription += "Authentication Required"
            userFriendlyDescription = .errors.loginRequired
            userFriendlyRecoverySuggestion = .errors.loginAdvice
        case 403:
            statusCodeDescription += "Forbidden"
            userFriendlyDescription = .errors.noPermission
        case 408:
            statusCodeDescription += "Request Timeout"
            userFriendlyDescription = .errors.requestTimedOut
            userFriendlyRecoverySuggestion = .errors.checkInternetConnectionAdvice
        case 400 ... 499:
            statusCodeDescription += "Bad request"
            isFatal = true
        case 500 ... 599:
            statusCodeDescription += "Server error"
        case 600:
            statusCodeDescription += "Outdated"
        default:
            statusCodeDescription += "Request failed"
        }

        return (statusCodeDescription, userFriendlyDescription, userFriendlyRecoverySuggestion, isFatal)
    }
}
