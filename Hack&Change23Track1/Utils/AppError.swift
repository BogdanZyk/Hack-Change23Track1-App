//
//  AppError.swift
//  Hack&Change23Track1
//
//  Created by Bogdan Zykov on 29.11.2023.
//

import Foundation

enum AppError {
    case network(type: Enums.NetworkError)
    case auth(type: Enums.AuthenticationError)
    case file(type: Enums.FileError)
    case custom(errorDescription: String?)

    class Enums { }
}

extension AppError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .network(let type): return type.localizedDescription
        case .file(let type): return type.localizedDescription
        case .custom(let errorDescription): return errorDescription
        case .auth(type: let type): return type.localizedDescription
        }
    }
}

// MARK: - Network Errors

extension AppError.Enums {
    enum NetworkError {
        case parsing
        case notFound
        case somethingWentWrong
        case notYetReceived
        case invalidServerResponse(String)
    }
}

extension AppError.Enums.NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidServerResponse(let code): return "Invalid server response. Code \(code)"
        case .parsing: return "Parsing error"
        case .notFound: return "URL Not Found"
        case .somethingWentWrong: return "Something went wrong, please try again"
        case .notYetReceived: return "Not yet received"
        }
    }

    var errorCode: Int? {
        switch self {
            case .parsing: return nil
            case .notFound: return 404
            case .somethingWentWrong, .invalidServerResponse, .notYetReceived: return 500
        }
    }
}

extension AppError.Enums {
    enum AuthenticationError {
        case noSetCurrentUser
    }
}

extension AppError.Enums.AuthenticationError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .noSetCurrentUser: return "No set current user"
        }
    }
}

// MARK: - File Errors

extension AppError.Enums {
    enum FileError {
        case read(path: String)
        case write(path: String, value: Any)
        case custom(errorDescription: String?)
    }
}

extension AppError.Enums.FileError: LocalizedError {
    var errorDescription: String? {
        switch self {
            case .read(let path): return "Could not read file from \"\(path)\""
            case .write(let path, let value): return "Could not write value \"\(value)\" file from \"\(path)\""
            case .custom(let errorDescription): return errorDescription
        }
    }
}
