//
//  Result.swift
//  JDI
//
//  Created by Vu Dinh Vinh on 8/20/19.
//  Copyright © 2019 <CompanyName>. All rights reserved.
//

import Foundation

enum APIError: Error {
    case noNetwork
    case requestFailed
    case invalidData
    case jsonParsingFailure
    case apiResponseError(_ statusCode: Int, message: String)

    var localizedDescription: String {
        switch self {
        case .noNetwork: return "No internet connection."
        case .requestFailed: return "Request failed."
        case .invalidData: return "Invalid data."
        case .jsonParsingFailure: return "Parse data failed."
        case .apiResponseError( _, let message): return message
        }
    }

    var code: Int {
        switch self {
        case .noNetwork: return 0
        case .requestFailed: return 0
        case .invalidData: return 0
        case .jsonParsingFailure: return 0
        case .apiResponseError(let statusCode, _): return statusCode
        }
    }
}

enum Result<T, U> where U: Error {
    case success(T)
    case failure(U)
}
