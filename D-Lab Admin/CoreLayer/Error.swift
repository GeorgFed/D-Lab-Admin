//
//  Error.swift
//  D-Lab Admin
//
//  Created by Egor Fedyaev on 14.03.2022.
//

import Foundation

typealias EmptyResult = Result<Void, Error>
typealias EmptyCompletion = (_ result: EmptyResult) -> Void

enum NetworkError: Error {
    case undefinedError
    case customError(_ error: Error)
    case invalidResponse(_ code: Int)
    case invalidURL(_ path: String)
    case noResponse
    case invalidData
    case noJWT
}

enum ParseError: Error {
    case undefinedError
    case customError(_ error: Error)
    case unexpectedNULL(_ message: String)
    case dateParseError(_ string: String)
}

enum AuthError: Error {
    case noBasicAuthToken
    case noJWTToken
    case undefined
    case custom(_ error: Error)
}

